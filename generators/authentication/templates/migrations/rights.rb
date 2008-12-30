class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %> do |t|
      t.string :controller_name, :nil => false
      t.string :action_name, :nil => false

      t.timestamps
    end
  end

  def self.down
    drop_table :<%= table_name %>
  end
end
