class Role < ActiveRecord::Base

  has_and_belongs_to_many :rights

  validates_presence_of :name
  validates_format_of :name, :with => /^[a-z_]+$/

  def before_validation
    self.name.downcase!
  end

end
