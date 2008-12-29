class CreateRights < ActiveRecord::Migration
  def self.up
    create_table :rights do |t|
      t.string :controller_name, :nil => false
      t.string :action_name, :nil => false

      t.timestamps
    end
  end

  def self.down
    drop_table :rights
  end
end
