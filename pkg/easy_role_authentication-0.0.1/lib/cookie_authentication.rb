module EasyRoleAuthentication
  module CookieAuthentication

    # Mixin
    def self.included(recipient)
      recipient.extend(ClassMethods)
      recipient.class_eval do
        include InstanceMethods
      end
    end

    module ClassMethods
      def secure_digest(*args)
        Digest::SHA1.hexdigest(args.flatten.join('--'))
      end

      def make_token
        secure_digest(Time.now, (1..10).map{ rand.to_s })
      end
    end # ClassMethods

    module InstanceMethods
      def remember_token?
        (!remember_token.blank?) &&
          remember_token_expires_at && (Time.now.utc < remember_token_expires_at.utc)
      end

      def remember_me
        remember_me_for 2.weeks
      end

      def remember_me_for(time)
        remember_me_until time.from_now.utc
      end

      def remember_me_until(time)
        self.remember_token_expires_at = time
        self.remember_token            = self.class.make_token
        save(false)
      end

      # refresh token (keeping same expires_at) if it exists
      def refresh_token
        if remember_token?
          self.remember_token = self.class.make_token
          save(false)
        end
      end


      # Deletes the server-side record of the authentication token.  The
      # client-side (browser cookie) and server-side (this remember_token) must
      # always be deleted together.
      def forget_me
        self.remember_token_expires_at = nil
        self.remember_token            = nil
        save(false)
      end

    end # InstanceMethods

  end # CookieAuthentication
end # EasyRoleAuthentication
