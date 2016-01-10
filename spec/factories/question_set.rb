FactoryGirl.define do
   sequence :value do |n|
      "Question #{n}?"
   end

   factory :question do 
     value
     used false
     association :question_set, factory: :question_set, name: "Topic" 
   end

   factory :user do
     first_name "Test"
     last_name "User"
     sequence(:email) { |n| "test#{n}@user.com" }
     password "password"
     password_confirmation "password"
   end
   
   factory :question_set do
      user
      sequence(:name) { |n| "Topic ##{n}" }
      description "This is a table topic question set"

      factory :question_set_with_questions do
        transient do
           questions_count 5
        end

        after(:create) do |question_set, evaluator|
           FactoryGirl.create_list(:question, evaluator.questions_count, question_set: question_set)
           question_set.reload
        end
      end
   end


end
