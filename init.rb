require File.dirname(__FILE__) + '/lib/cookie_authentication'
require File.dirname(__FILE__) + '/lib/password_authentication'
require File.dirname(__FILE__) + '/lib/user_methods'
require File.dirname(__FILE__) + '/lib/helper_methods'
require File.dirname(__FILE__) + '/lib/controller_methods'

ActionController::Base.send :include, EasyAuthentication::ControllerMethods
ActionController::Base.send :include, EasyAuthentication::HelperMethods
