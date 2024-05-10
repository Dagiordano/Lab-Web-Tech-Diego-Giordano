Rails.application.routes.draw do
  root 'posts#index'

  
  
 

  resources :posts do
    resources :comments
  end

  get '/comments', to: 'comments#index'


  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/home', to: 'static_pages#home'
end