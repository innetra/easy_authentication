class CreateRightsRoles < ActiveRecord::Migration
  def self.up
    create_table :rights_roles, :id => false do |t|
      t.integer :right_id, :nil => false
      t.integer :role_id, :nil => false
    end
  end

  def self.down
    drop_table :rights_roles
  end
end
