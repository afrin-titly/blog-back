Rails.application.routes.draw do
  get '/users/confirmation', to: 'users#confirm_user'
  post '/auth/login', to: 'authentication#login'
  delete '/followers/unfollow', to: 'followers#destroy'
  resources :followers
  #  do
  #   delete 'unfollow', to: 'followers#delete'
  # end
  resources :posts
  resources :comments
  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
