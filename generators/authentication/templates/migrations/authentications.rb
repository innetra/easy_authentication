class CreateAuthentications < ActiveRecord::Migration

  def self.up

    create_table :rights do |t|
      t.string :controller_name, :nil => false
      t.string :action_name, :nil => false

      t.timestamps
    end

    create_table :rights_roles, :id => false do |t|
      t.integer :right_id, :nil => false
      t.integer :role_id, :nil => false
    end

    create_table :roles do |t|
      t.string :name, :nil => false
      t.text :description

      t.timestamps
    end

    create_table :roles_users, :id => false do |t|
      t.integer :role_id, :nil => false
      t.integer :user_id, :nil => false
    end

    create_table :users do |t|
      t.string :login
      t.string :password_hash, :null => false
      t.string :password_salt, :null => false
      t.string :remember_token, :limit => 40
      t.string :remember_token_expires_at
      t.boolean :enabled, :default => false
<% unless default_options[:use_easy_contacts] -%>
      t.string :name
      t.string :last_name
      t.string :email
<% end -%>

      t.timestamps
    end

  end

  def self.down
    drop_table :rights
    drop_table :rights_roles
    drop_table :roles
    drop_table :roles_users
    drop_table :users
  end

end
