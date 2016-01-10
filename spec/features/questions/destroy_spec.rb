require 'rails_helper'

describe "Destroying a question" do
  let!(:question) { FactoryGirl.create(:question) }
  before { sign_in question.question_set.user, password: "password" }

  it "redirects to the question set on success" do
    question_set = QuestionSet.find(question.question_set_id)
    expect(Question.count).to eq(1)
    visit "/question_sets/#{question.question_set_id}"
    within "#question_#{question.id}" do
      click_link "Destroy"
    end
    expect(Question.count).to eq(0)
    expect(page).to have_content "Question was successfully destroyed."
    expect(page).to have_content question_set.name  
  end
  
end
