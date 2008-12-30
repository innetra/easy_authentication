module EasyRoleAuthentication
  module UserMixin

    def self.included(recipient)
      recipient.extend(ClassMethods)
      recipient.class_eval do
        include InstanceMethods
        include EasyRoleAuthentication::PasswordAuthentication
        include EasyRoleAuthentication::CookieAuthentication

        # Virtual attribute for the unencrypted password
        attr_accessor :password

        has_and_belongs_to_many :roles

        validates_length_of :login,:minimum => 4
        validates_presence_of :login, :on => :create
        validates_uniqueness_of :login, :case_sensitive => false

        validates_presence_of     :password,                   :if => :password_required?
        validates_presence_of     :password_confirmation,      :if => :password_required?
        validates_confirmation_of :password,                   :if => :password_required?
        validates_length_of       :password, :minimum => 6,    :if => :password_required?

        before_save :encrypt_password

        # prevents a user from submitting a crafted form that bypasses activation
        # anything else you want your user to change should be added here.
        attr_accessible :login, :password, :password_confirmation,
          :role_ids, :full_name, :name, :last_name

      end
    end

    module ClassMethods

      def authenticate(login, password)
        return if login.blank? || password.blank?
        u = User.find_by_login(login)
        u = u.authenticated?(password) ? u : nil
      end

      # Encrypts some data with the salt.
      def encrypt(password, salt)
        Digest::SHA1.hexdigest("--#{salt}--#{password}--")
      end

    end # EasyAuthentication::User::ClassMethods

    module InstanceMethods

      def to_param
        self.login
      end

      # Encrypts the password with the user salt
      def encrypt(password)
        self.class.encrypt(password, password_salt)
      end

      def authenticated?(password)
        password_hash == encrypt(password)
      end

      protected

        # before filter
        def encrypt_password
          return if password.blank?
          self.password_salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
          self.password_hash = encrypt(password)
        end

    end # EasyAuthentication::User::InstanceMethods

  end # EasyAuthentication::User
end # EasyAuthentication
