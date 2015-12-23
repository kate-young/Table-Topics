require 'rails_helper'

describe "Editting a question set" do
   def edit_question_set(options={})
     options[:name] ||= "New Name"
     options[:description] ||= "This is a new description."

     visit '/question_sets'
     within "#question_set_#{question_set.id}" do
       click_link "Edit"
     end 

     fill_in "Name", with: options[:name]
     fill_in "Description", with: options[:description]
     click_button "Edit Question Set" 
     options
   end

   let!(:question_set) { FactoryGirl.create(:question_set) }

   it "redirects to question set list on success" do
     editted_question_set = edit_question_set question_set: question_set

     expect(page).to have_content editted_question_set[:name]
     expect(page).to have_content "Question set was successfully updated"
   end

   it "displays an error when title is blank" do
     edited_question_set = edit_question_set question_set: question_set, name: ""

     expect(page).to have_content edited_question_set[:description]
     expect(page).to have_content "can't be blank"
   end
end
