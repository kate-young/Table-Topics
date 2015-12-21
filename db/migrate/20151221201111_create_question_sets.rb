class CreateQuestionSets < ActiveRecord::Migration
  def change
    create_table :question_sets do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
