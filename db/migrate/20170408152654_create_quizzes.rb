class CreateQuizzes < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes do |t|
      t.string :title
      t.boolean :tombstone, default: false, null: false

      t.timestamps
    end
  end
end
