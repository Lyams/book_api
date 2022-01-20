class FixEmailUniqueIndex < ActiveRecord::Migration[7.0]
  def up
    remove_index :users, :email
    execute "CREATE UNIQUE INDEX index_users_on_lowercase_email 
             ON users (lower(email));"
  end

  def down
    execute "DROP INDEX index_users_on_lowercase_email;"
    add_index :users, :email, :unique => true
  end
end
