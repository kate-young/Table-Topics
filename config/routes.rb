Rails.application.routes.draw do
  get "/table_topics", to: "question_sets#table_topics"
  get "/table_topics/:id", to: "question_sets#chose", as: "chose"
  resources :question_sets do
     resources :questions
  end
end
