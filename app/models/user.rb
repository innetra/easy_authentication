require 'digest/sha1'

class User < ActiveRecord::Base
  include EasyAuthentication::UserMethods
end
