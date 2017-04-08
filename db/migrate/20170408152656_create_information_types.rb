class CreateInformationTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :information_types do |t|
      t.string :title
      t.boolean :tombstone, default: false, null: false

      t.timestamps
    end
  end
end
