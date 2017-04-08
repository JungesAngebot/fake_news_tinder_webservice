class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :uuid
      t.string :notification_token
      t.references :user, index: true
      t.string :os
      t.string :os_version
      t.integer :os_version_code
      t.string :device_model
      t.string :device_manufacturer
      t.string :app_version
      t.integer :app_version_int
      t.integer :device_resolution_height
      t.integer :device_resolution_width
      t.integer :device_diagonal
      t.boolean :developer
      t.boolean :statistic_flag

      t.boolean :tombstone

      t.timestamps
    end
  end
end
