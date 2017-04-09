class CreateAnswerGivens < ActiveRecord::Migration[5.0]
  def change
    create_table :answer_givens do |t|
      t.references :user, foreign_key: true
      t.references :quiz, foreign_key: true
      t.references :information, foreign_key: true
      t.references :answer, foreign_key: true
      t.boolean :tombstone, default: false, null: false

      t.timestamps
    end
  end
end
