Rails.application.routes.draw do
  
  get '/', to: 'welcome#index'
  get '/about', to: 'about#index'
  
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'

  get '/profile', to: 'users#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/profile/edit', to: 'users#edit'
  patch '/profile', to: 'users#update'

  get '/user/password/edit', to: 'users_password#edit'
  patch '/user/password', to: 'users_password#update'

  get '/reservation', to: 'reservations#index'
  get '/reservation/new', to: 'reservations#new'
  post '/reservation', to: 'reservations#create'
  delete '/reservation/:id', to: 'reservations#destroy'

  namespace :admin do
    get '/', to: 'dashboard#index'
    get '/bookings', to: 'bookings#index'

    get '/products', to: 'products#index'
    post 'products', to: 'products#create'
    delete 'products/:id', to: 'products#destroy'
    get '/products/new', to: 'products#new'
    get '/products/:id/edit', to: 'products#edit'
    patch '/products/:id', to: 'products#update'

    get '/users/new', to: 'users#new'
    get '/users/:id', to: 'users#show'
    get '/users/:id/edit', to: 'users#edit'
    patch '/users/:id', to: 'users#update'
    get '/users', to: 'users#index'
    delete '/users/:id', to: 'users#delete'
    post '/users', to: 'users#create'
    
    get '/users/:id/reservation/new', to: 'bookings#new'
    post '/users/:id/reservation', to: 'bookings#create'
  end

end