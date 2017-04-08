class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :text
      t.references :information_type, foreign_key: true
      t.boolean :tombstone, default: false, null: false

      t.timestamps
    end
  end
end
