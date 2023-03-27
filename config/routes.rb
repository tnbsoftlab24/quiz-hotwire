Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'quizzes#index'
  resources :quizzes do
    resources :questions, except: [:index] do
      resources :answers, except: [:index]
    end
  end
end
