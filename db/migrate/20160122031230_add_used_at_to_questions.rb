class AddUsedAtToQuestions < ActiveRecord::Migration
  def change

    add_column :questions, :used_at, :datetime
  end
end
