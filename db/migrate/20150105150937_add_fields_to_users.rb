class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tombstone, :boolean
  end
end
