require 'rails_helper'

RSpec.describe QuestionSet, type: :model do

   it "is valid with a name and description" do
      FactoryGirl.create(:question_set).should be_valid
   end

   it { should validate_presence_of(:name) }

   it { should validate_presence_of(:description) }

   it { should have_many(:questions) }

   it "validates uniqueness of name" do
      FactoryGirl.create(:question_set).should be_valid
      should validate_uniqueness_of(:name) 
   end

   it "reset method sets used to false for all question sets" do
      question_set = FactoryGirl.create(:question_set_with_questions)
      question_set.questions.each do |question|
         question.update(used: true)
      end
      question_set.reset
      question_set.questions.each do |question|
	 expect(question.used).to eq(false)
      end
   end
end
