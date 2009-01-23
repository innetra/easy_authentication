require 'rake'
require 'cookie_authentication'
require 'password_authentication'
require 'user_methods'
require 'helper_methods'
require 'controller_methods'

ActionController::Base.send :include, EasyAuthentication::ControllerMethods
ActionController::Base.send :include, EasyAuthentication::HelperMethods
