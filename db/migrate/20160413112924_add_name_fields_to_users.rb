class AddNameFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, after: :encrypted_password
    add_column :users, :last_name, :string, after: :first_name
  end
end
