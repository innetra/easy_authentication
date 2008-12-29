module EasyRoleAuthentication
  module PasswordAuthentication

    # Mixin
    def self.included(recipient)
      recipient.extend(ClassMethods)
      recipient.class_eval do
        include InstanceMethods

        # Virtual attribute for the unencrypted password
        attr_accessor :password
        validates_presence_of     :password,                   :if => :password_required?
        validates_presence_of     :password_confirmation,      :if => :password_required?
        validates_confirmation_of :password,                   :if => :password_required?
        validates_length_of       :password, :minimum => 6,    :if => :password_required?
        before_save :encrypt_password
      end
    end

    module ClassMethods
      # This provides a modest increased defense against a dictionary attack if
      # your db were ever compromised, but will invalidate existing passwords.
      # See the README and the file config/initializers/site_keys.rb
      #
      # It may not be obvious, but if you set REST_AUTH_SITE_KEY to nil and
      # REST_AUTH_DIGEST_STRETCHES to 1 you'll have backwards compatibility with
      # older versions of restful-authentication.
      def password_digest(password, salt)
        digest = REST_AUTH_SITE_KEY
        REST_AUTH_DIGEST_STRETCHES.times do
          digest = secure_digest(digest, salt, password, REST_AUTH_SITE_KEY)
        end
        digest
      end
    end # ClassMethods

    module InstanceMethods
      # Encrypts the password with the user salt
      def encrypt(password)
        self.class.password_digest(password, salt)
      end

      def authenticated?(password)
        password_hash == encrypt(password)
      end

      # before filter
      def encrypt_password
        return if password.blank?
        self.salt = self.class.make_token if new_record?
        self.password_hash = encrypt(password)
      end

      def password_required?
        password_hash.blank? || !password.blank?
      end
    end # InstanceMethods

  end # PasswordAuthentication
end # EasyRoleAuthentication
