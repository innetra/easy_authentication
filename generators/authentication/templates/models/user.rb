class User < ActiveRecord::Base
  include EasyRoleAuthentication::UserMixin
end
