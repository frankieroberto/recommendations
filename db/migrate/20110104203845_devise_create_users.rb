class DeviseCreateUsers < ActiveRecord::Migration
  def self.up

    # Remove columns used by old Restful Authentication plugin
    remove_column :users, :crypted_password
    remove_column :users, :salt
    
    # Add columns used by Devise
    add_column :users, :encrypted_password, :string, :limit => 128, :null => false, :default => ""
    add_column :users, :password_salt, :string, :null => false, :default => ""
    add_column :users, :reset_password_token, :string
    add_column :users, :remember_created_at, :datetime
    add_column :users, :sign_in_count, :integer, :default => 0
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_ip, :string        

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end

  def self.down

    # Drop columns used by Devise
    drop_column :users, :last_sign_in_ip
    drop_column :users, :current_sign_in_ip
    drop_column :users, :last_sign_in_at
    drop_column :users, :current_sign_in_at
    drop_column :users, :sign_in_count
    drop_column :users, :remember_created_at
    drop_column :users, :reset_password_token
    drop_column :users, :password_salt
    drop_column :users, :encrypted_password
    
    # Add columns used by Restful Authentication
    add_column :users, :salt, :string
    add_column :users, :crypted_password, :string
                        
  end
end
