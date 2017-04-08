class CreateMemes < ActiveRecord::Migration[5.0]
  def change
    create_table :memes do |t|
      t.string :image_url
      t.references :category, foreign_key: true
      t.float :min_correct_including
      t.float :max_correct_excluding
      t.boolean :tombstone, default: false, null: false

      t.timestamps
    end
  end
end
