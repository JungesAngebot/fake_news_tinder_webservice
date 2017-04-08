class CreateQuizInformations < ActiveRecord::Migration[5.0]
  def change
    create_table :quiz_informations do |t|
      t.references :quiz, foreign_key: true
      t.references :information, foreign_key: true
      t.boolean :tombstone, default: false, null: false

      t.timestamps
    end
  end
end
