class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :question_set, index:true
      t.boolean :used
      t.timestamps null: false
    end
  end
end
