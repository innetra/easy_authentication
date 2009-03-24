class User < ActiveRecord::Base
  include EasyAuthentication::UserMethods
end
