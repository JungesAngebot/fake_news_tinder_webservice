class AddDefaultValueToTombstoneInUsers < ActiveRecord::Migration
  def up
    change_column :users, :tombstone, :boolean, :default => false

    User.unscoped.where('tombstone IS NULL').update_all(tombstone: false)
  end

  def down
    change_column :users, :tombstone, :boolean, :default => nil
  end
end
