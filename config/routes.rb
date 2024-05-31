Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }



  root 'static_pages#home'

  resources :users
  
 

  resources :posts do
    resources :comments
  end




  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/home', to: 'static_pages#home'
end