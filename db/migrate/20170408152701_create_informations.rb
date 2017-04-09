class CreateInformations < ActiveRecord::Migration[5.0]
  def change
    create_table :informations do |t|
      t.text :challenge_text
      t.text :result_text
      t.references :information_type, foreign_key: true
      t.string :source_link
      t.references :correct_answer, foreign_key: {to_table: :answers}
      t.references :category, foreign_key: true
      t.boolean :tombstone, default: false, null: false

      t.timestamps
    end
  end
end
