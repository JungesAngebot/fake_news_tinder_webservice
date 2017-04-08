class AddDefaultValueToTombstoneDevices < ActiveRecord::Migration
    def up
      change_column :devices, :tombstone, :boolean, :default => false

      Device.unscoped.where('tombstone IS NULL').update_all(tombstone: false)
    end

    def down
      change_column :devices, :tombstone, :boolean, :default => nil
    end
  end

