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

end
