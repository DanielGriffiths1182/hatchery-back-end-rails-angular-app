Rails.application.routes.draw do
  resources :users

  root to: '/'
  
  get '/user'  => 'users#new'

  post '/user'  => 'users#create'

  post '/create' => 'eggs#create'

  get '/show' => 'eggs#show'

  put '/edit' => 'eggs#update'
end
