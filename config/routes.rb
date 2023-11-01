Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      resources :subscriptions, only: [:create, :update, :index]
      post "/subscriptions", to: "subscriptions#create"
      patch "/subscriptions/:id", to: "subscriptions#update"
      get "/subscriptions/:id/subscriptions", to: "subscriptions#index"
    end
  end
end
