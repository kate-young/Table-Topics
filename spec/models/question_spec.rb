require 'rails_helper'

RSpec.describe Question, type: :model do

  it "is valid with a value" do
     question = FactoryGirl.build(:question)
     question.new_record?
     question.question_set.new_record?
  end

  it { should belong_to(:question_set)}

  it { should validate_presence_of(:value)}

  it { should validate_uniqueness_of(:value).scoped_to(:question_set_id) }

  describe "used attributes are set correctly" do
     let!(:question) { FactoryGirl.create(:question) }
     
     it "used is set to false on creation" do
        expect(question.used).to eq(false)
     end

     it "use method sets used attribute to false" do
         question.use
         expect(question.used).to eq(true)
     end

     it "reset method sets used attribute to true" do
	 question.use
	 question.reset
	 expect(question.used).to eq(false)
     end
  end
end
