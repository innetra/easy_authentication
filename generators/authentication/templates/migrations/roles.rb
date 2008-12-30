class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %> do |t|
      t.string :name, :nil => false
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :<%= table_name %>
  end
end
