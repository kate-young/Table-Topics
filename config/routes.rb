Rails.application.routes.draw do
  resources :user_sessions, only: [:new, :create]
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :table_topics, only: [:index, :show]
  get "/login", to: "user_sessions#new"
  get "/logout", to: "user_sessions#destroy"
  get "/table_topics", to: "table_topics#index"
  get "/table_topics/:id/random_question", to: "table_topics#random_question", as: "random"
  get "/table_topics/:id/reset_questions", to: "table_topics#reset_questions", as: "reset_questions"
  resources :question_sets do
     resources :questions
  end
end
