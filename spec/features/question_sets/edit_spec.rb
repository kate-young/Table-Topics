require 'rails_helper'

describe "Editting a question set" do
   def edit_question_set(options={})
   end
   
   before(:all) do
      QuestionSet.create(name: "Table Topics Questions", description: "List of questions for table topics")
   end
end
