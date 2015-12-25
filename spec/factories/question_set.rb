FactoryGirl.define do
   factory :question_set do
      name "Topic"
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

   sequence :value do |n|
      "Question #{n}?"
   end

   factory :question do 
      value
      used false
      association :question_set, factory: :question_set, name: "Topic" 
   end
end
