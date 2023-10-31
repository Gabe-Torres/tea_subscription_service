Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      resources :subscriptions, only: [:create, :update]
      post "/subscriptions", to: "subscriptions#create"
      patch "/subscriptions/:id", to: "subscriptions#update"
    end
  end
end
