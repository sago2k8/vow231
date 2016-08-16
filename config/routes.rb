Rails.application.routes.draw do
  get 'static_pages/home'


  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations',  }
  post '/signup' => 'splash#signup', as: :splash_signup
  get '/splash' => 'splash#index'
  root 'static_pages#home'
  get '/setup' => 'setup#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
