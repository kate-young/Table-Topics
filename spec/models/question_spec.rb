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

     it "used_at is nil on creation" do
         expect(question.used_at).to be(nil)
     end

     it "use method sets used attribute to false" do
         question.use
         expect(question.used).to eq(true)
     end

     it "use method sets used_at attribute" do
         question.use
         expect(question.used_at).to_not be(nil)
     end

     it "reset method sets used attribute to true" do
         question.use
         question.reset
         expect(question.used).to eq(false)
     end

     it "reset mothod sets used_at to nil" do
         question.use
         question.reset
         expect(question.used_at).to be(nil)
     end
  end
end
