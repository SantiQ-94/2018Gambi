Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'web#index'
  post "/login", to: 'web#login'
  get "/logout", to: 'web#logout'

end
