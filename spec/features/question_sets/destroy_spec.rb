require 'rails_helper' 

describe "Destroying a question set" do
  let!(:question_set) { FactoryGirl.create(:question_set) }
  before { sign_in question_set.user, password: "password" } 

  it "redirects to the question set list on success" do
    expect(QuestionSet.count).to eq(1)

    visit "/question_sets"
    within "#question_set_#{question_set.id}" do
      click_link "Destroy"
    end
    
    expect(QuestionSet.count).to eq(0)
    expect(page).to have_content "Question set was successfully destroyed"
  end
end
