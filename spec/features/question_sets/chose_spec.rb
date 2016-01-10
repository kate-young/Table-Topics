require 'rails_helper'

describe "Choosing a question set", :js => true do

  def use_all_questions(options={})
    question_set = options[:question_set]
    question_set.questions.each { |question| question.use }
  end

  let!(:question_set) { FactoryGirl.create(:question_set_with_questions) }

  before do
    sign_in question_set.user, password: "password"
  end
  it "marks all questions as unused when selecting reset" do
    use_all_questions question_set: question_set

    visit "/table_topics/#{question_set.id}"
    click_link "Reset"
    visit "/table_topics/#{question_set.id}"

    expect(question_set.questions.used.count).to eq(0)
  end
  describe "When there are unused questions" do
    it "clicking get random question displays an unused question" do
      visit "/table_topics/#{question_set.id}"

      click_link "Select Random Question"
      
      within "#random_question" do 
	expect(page).to have_content
      end	
    end
  end
  describe "When there are no unused questions" do
    it "link to get random question shows no more questions" do
      use_all_questions question_set: question_set
      
      visit "/table_topics/#{question_set.id}"
      click_link "Select Random Question"

      expect(page).to have_content("No more questions")
    end
  end
  describe "When there are used questions" do
    it "shows a list of all used questions" do
       use_all_questions question_set: question_set

       visit "/table_topics/#{question_set.id}"

       within "#used_questions" do
	 expect(page).to have_selector('li', count: 5) 
       end
    end
  end
end
