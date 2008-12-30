class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %>, :id => false do |t|
      t.integer :role_id, :nil => false
      t.integer :user_id, :nil => false
    end
  end

  def self.down
    drop_table :<%= table_name %>
  end
end
