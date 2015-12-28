Rails.application.routes.draw do
  resources :users
  get "/table_topics", to: "question_sets#table_topics"
  get "/table_topics/:id", to: "question_sets#chose", as: "chose"
  get "/table_topics/:id/random_question", to: "question_sets#random_question", as: "random"
  get "/table_topics/:id/reset_questions", to: "question_sets#reset_questions", as: "reset_questions"
  resources :question_sets do
     resources :questions
  end
end
