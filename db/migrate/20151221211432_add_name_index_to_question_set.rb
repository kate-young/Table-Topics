class AddNameIndexToQuestionSet < ActiveRecord::Migration
  def change
    add_index :question_sets, :name, unique: true
  end
end
