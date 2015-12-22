class AddValueToQuestions < ActiveRecord::Migration
  def change
     add_column :questions, :value, :text
  end
end
