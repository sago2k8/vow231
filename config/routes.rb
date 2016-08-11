Rails.application.routes.draw do
  post '/signup' => 'splash#signup', as: :splash_signup
  get '/splash' => 'splash#index'
  root 'splash#index'
  get '/setup' => 'setup#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
