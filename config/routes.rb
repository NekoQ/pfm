Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :callbacks do
    post :success, :fail, :notify
  end

  namespace :api do
    resources :users, only: %i[show create update destory]

    namespace :auth do
      post :sign_in
    end

    namespace :connect do
      post :connect, :reconnect, :refresh
    end

    resources :accounts, only: [:index]
    namespace :transactions do
      get '/' => :index
      get :search
    end

    resources :budget, only: %i[create show index destroy]
  end
end
