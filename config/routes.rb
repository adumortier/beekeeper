
Rails.application.routes.draw do

  get '/', to: 'welcome#index', as: 'root'
  
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'

  get '/products', to: 'products#index'

  get '/profile', to: 'users#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/profile/edit', to: 'users#edit'
  patch '/profile', to: 'users#update'

  get '/user/password/edit', to: 'users_password#edit'
  patch '/user/password', to: 'users_password#update'

  get '/passwords/new', to: 'passwords#new'
  post '/passwords', to: 'passwords#create'
  get '/passwords/reset/:id', to: 'passwords#reset'
  patch '/passwords/:id', to: 'passwords#update'
  get '/passwords/edit/:id', to: 'passwords#edit'

  get '/reservation', to: 'reservations#index'
  get '/reservation/new', to: 'reservations#new'
  post '/reservation', to: 'reservations#create'
  delete '/reservation/:id', to: 'booking_products#destroy'

  namespace :admin do
    get '/bookings', to: 'bookings#index'

    resources :products, except: :show
    resources :users
    resources :posts, except: :show

    get '/users/:id/reservation/new', to: 'bookings#new'
    post '/users/:id/reservation', to: 'bookings#create'
    get '/users/:user_id/reservation/:booking_id/edit', to: 'bookings#edit'
    patch '/users/:user_id/reservation/:booking_id', to: 'bookings#update'
  end

  match '*path', to: 'static_pages#not_found', via: :all,  constraints: -> (req) { req.fullpath !~ /^\/rails\/active_storage\/blobs\/.*/ } 

end