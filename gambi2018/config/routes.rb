Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'web#index'
  post "/login", to: 'web#login'
  get "/logout", to: 'web#logout'
  post "/reserve/:table_id", to: "web#reserve"
  post "/join/:table_id", to: "web#join"

  namespace :admin do
  	resources :tables do 
  		post "reserve"
  		post "add_member"
      put "confirm"
      put "unconfirm"
      post "cancel"
  	end

    resources :members
  end
end
