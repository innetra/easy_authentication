module EasyAuthentication
  module UserMethods

    def self.included(recipient)
      recipient.extend(ClassMethods)
      recipient.class_eval do

        include InstanceMethods
        include EasyAuthentication::PasswordAuthentication
        include EasyAuthentication::CookieAuthentication

        has_and_belongs_to_many   :roles

        validates_presence_of     :first_name
        validates_presence_of     :last_name
        validates_presence_of     :email
        validates_presence_of     :login, :on => :create

        validates_format_of       :login, :with => /^[a-z_.]+$/
        validates_format_of       :email,
          :with => /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/

        validates_length_of       :login, :minimum => 4

        validates_uniqueness_of   :email, :case_sensitive => false
        validates_uniqueness_of   :login, :case_sensitive => false

        # Virtual attribute for the unencrypted password and current_password
        attr_accessor             :password
        attr_accessor             :current_password

        validates_presence_of     :password,                :if => :password_required?
        validates_presence_of     :password_confirmation,   :if => :password_required?
        validates_confirmation_of :password,                :if => :password_required?
        validates_length_of       :password, :minimum => 6, :if => :password_required?

        before_save :encrypt_password

        # prevents a user from submitting a crafted form that bypasses activation
        # anything else you want your user to change should be added here.
        attr_accessible :first_name, :last_name, :full_name, :email, :login,
          :password, :password_confirmation, :current_password, :role_ids,
          :password_reset_token

      end
    end

    module ClassMethods

      # Generate reset password token (it does not reset password!)
      def reset_password(login)
        return if login.blank?
        return unless u = User.first(:conditions => "login = '#{login}' OR email = '#{login}'")
        u.password_reset_token = make_token
        u.save
        return u
      end

      def authenticate(login, password)
        return if login.blank? || password.blank?
        u = User.first(:conditions => "login = '#{login}' OR email = '#{login}'")
        u = u.authenticated?(password) ? u : nil
      end

      # Encrypts some data with the salt
      def encrypt(password, salt)
        Digest::SHA1.hexdigest("--#{salt}--#{password}--")
      end

    end # EasyAuthentication::User::ClassMethods

    module InstanceMethods

      def to_param
        self.login
      end

      def full_name
        "#{self.first_name} #{self.last_name}"
      end

      # Encrypts the password with the user salt
      def encrypt(password)
        self.class.encrypt(password, password_salt)
      end

      def authenticated?(password)
        password_hash == encrypt(password)
      end

      def authorized?(controller_name, action_name)
        self.roles.each do |role|
          return true if role.rights.find_by_controller_name_and_action_name(controller_name, action_name)
        end
        return false
      end

      protected

        # before filter
        def encrypt_password
          return if password.blank?
          self.password_salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
          self.password_hash = encrypt(password)
        end

    end # EasyAuthentication::User::InstanceMethods

  end # EasyAuthentication::UserMethods
end # EasyAuthentication
