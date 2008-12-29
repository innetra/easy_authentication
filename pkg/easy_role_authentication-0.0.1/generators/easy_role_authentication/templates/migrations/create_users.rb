class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :password_hash, :null => false
      t.string :password_salt, :null => false
      add_column :users, :remember_token, :string, :limit => 40
      add_column :users, :remember_token_expires_at, :datetime
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
    drop_table :users
  end
end
