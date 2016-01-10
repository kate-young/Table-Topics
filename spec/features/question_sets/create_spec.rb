require 'rails_helper'

describe "Creating a new question set" do
   let!(:user) { FactoryGirl.create(:user) }
   before { sign_in user, password: "password" }

   def create_question_set(options={})
      options[:name] ||= "Table Topics Questions"
      options[:description] ||= "List of questions for table topics"
      visit "/question_sets"
      click_link "Add New"

      fill_in "Name", with: options[:name]
      fill_in "Description", with: options[:description]

      click_button "Create Question Set"
      options
   end

   it "shows the newly created question set on success" do
      expect(QuestionSet.count).to eq(0)
      valid_attributes = create_question_set

      expect(page).to have_content("Question set was successfully created.")
      expect(page).to have_content(valid_attributes[:name])
      expect(page).to have_content(valid_attributes[:description])
      expect(QuestionSet.count).to eq(1)
   end

   it "displays an error when the question set has no name" do
      create_question_set :name => ""

      expect(page).to have_content("Name can't be blank")
      expect(QuestionSet.count).to eq(0)
   end

   it "displays an error when the question set has no description"  do
      create_question_set :description => ""
      
      expect(page).to have_content("Description can't be blank")
      expect(QuestionSet.count).to eq(0)
   end

   it "displays an error when a question set with the same name has already been created"  do
      user.question_sets.create(name: "Table Topics Questions", description: "List")
      expect(QuestionSet.count).to eq(1)
      create_question_set

      expect(page).to have_content("Name has already been taken")
      expect(QuestionSet.count).to eq(1)
   end
end
