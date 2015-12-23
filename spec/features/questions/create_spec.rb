require 'rails_helper'

describe "Creating a new question" do
  def create_question(options = {})
    options[:value] ||= "What is your favorite color?" 
    question_set = options[:question_set]

    visit '/question_sets'  
    within "#question_set_#{question_set.id}" do
       click_link "Show"
    end
    
    click_link "Add Question"
    fill_in "question_value", with: options[:value]
    click_button "Create Question"
    options[:value]
  end

  let!(:question_set) { FactoryGirl.create(:question_set) }

  it "redirects to show question set page on success with new question" do
    expect(question_set.questions.count).to eq(0)

    question = create_question question_set: question_set

    expect(question_set.questions.count).to eq(1)
    expect(page).to have_content question 
  end

  it "displays an error when the question value is blank" do
    create_question value: "", question_set: question_set

    expect(question_set.questions.count).to eq(0)
    expect(page).to have_content "can't be blank"
  end
end
