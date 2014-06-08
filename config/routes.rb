PostitTemplate::Application.routes.draw do

  root to: 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :posts, except: [:destroy] do 
    resources :comments, only: [:create]
  end

  resources :categories, only: [:create, :new, :show]
  get '/register', to: 'users#new' 
  resources :users, only: [:show, :edit, :create, :update]

end
