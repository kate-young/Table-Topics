Rails.application.routes.draw do
  resources :question_sets do
     resources :questions
  end
end
