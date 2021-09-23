Rails.application.routes.draw do
  # get '/articles', to: "articles#index" #specific crud actions
  resources :articles, only: %i[index show]  #all crud actions
end
