class AddUserIdToQuestionSets < ActiveRecord::Migration
  def up 
    add_column :question_sets, :user_id, :integer
  end
  def down
    remove_column :question_sets, :user_id
  end
end
