class User < ActiveRecord::Base
  include EasyRoleAuthentication::UserMixin

  <% if default_options[:use_easy_contacts] -%>
  # Get's full name from contact
  delegate :full_name, :to => :person
  delegate :name, :to => :person
  delegate :last_name, :to => :person
  <% else -%>
  validates_presence_of :email
  validates_format_of :email, :with => /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
  <% end -%>

end
