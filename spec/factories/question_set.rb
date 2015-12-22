FactoryGirl.define do
   factory :question_set do
      name "Topic"
      description "This is a table topic question set"

      factory :question_set_with_questions do
        ignore do
           questions_count 5
        end

        after(:create) do |question_sit, evaluator|
           FactoryGirl.create_list(:question, evaluator.questions_count, question: question)
           question_set.reload
        end
      end
   end

   factory :question do 
      value "What is your favorite color"
      used false
      association :question_set, factory: :question_set, name: "Topic" 
   end
end
