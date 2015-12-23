require 'rails_helper'

describe "Editing a question" do
  def edit_question(options = {})
    options[:value] ||= "What is your name?"

    visit "/question_sets/#{question.question_set_id}"
    within "#question_#{question.id}" do
      click_link "Edit"
    end

    fill_in "question_value", with: options[:value]
    click_button "Edit Question"
    
    options[:value]
  end

  let!(:question) { FactoryGirl.create(:question) }
  
  it "redirects to show question set on success with updated question" do
     editted_question = edit_question question: question

     expect(page).to have_content editted_question
  end
end
