require 'rails_helper'

RSpec.describe Question, type: :model do

  it "is valid with a value" do
     question = FactoryGirl.build(:question)
     question.new_record?
     question.question_set.new_record?
  end

  it "used is set to false on creation" do
     question = FactoryGirl.build(:question)
     question.used == false
  end

  it { should belong_to(:question_set)}

  it { should validate_presence_of(:value)}

end
