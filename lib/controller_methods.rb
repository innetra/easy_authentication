module EasyAuthentication
  module ControllerMethods
    def self.included(recipient)
      recipient.class_eval do
        # Requires valid user credentials on all actions and controllers
        before_filter :login_required
        # Filter password from log
        filter_parameter_logging :password
      end
    end
  end
end
