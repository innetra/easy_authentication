class User < ActiveRecord::Base
  include EasyRoleAuthentication::UserMixin

<% if options[:use_easy_contacts] -%>
  has_one :person
  validates_associated :person

  # Get's full name from contact
  delegate :full_name, :to => :person
  delegate :name, :to => :person
  delegate :last_name, :to => :person

  attr_accessible :person_attributes

  def person_attributes=(person_attributes)
    self.person = Person.new(person_attributes)
  end


<% else -%>
  validates_presence_of :email
  validates_format_of :email, :with => /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/

  attr_accessible :email

  def full_name
    "#{self.name} #{self.last_name}"
  end

<% end -%>

end
