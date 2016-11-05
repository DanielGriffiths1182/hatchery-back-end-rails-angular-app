Rails.application.routes.draw do
  resources :users
  root 'users#show'

  get '/login' => 'users#login'

  get '/user'  => 'users#new'

  post '/user'  => 'users#create'

  post '/create' => 'eggs#create'

  get '/show' => 'eggs#show'

  put '/edit' => 'eggs#update'

  get '/weather' => 'eggs#weather'
end
