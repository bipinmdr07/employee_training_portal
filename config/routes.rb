Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'trainingevent/new'
  get 'trainingevent/getemployeelist'
  post 'trainingevent/create'
  get 'version/new'
  post 'version/create'
  get 'applicationuserinrole/new'
  post 'applicationuserinrole/create'
  get 'course/new'
  post 'course/create'
  post 'applicationuser/create'
  post 'applicationuserinrole/create'
  root :to => "login#login"
  match "signup", :to => "applicationuser#new", via: [:get]
  match "login", :to => "login#login", via: [:get, :post]
  match "logout", :to => "login#logout", via: [:get]
  match "home", :to => "login#home", via: [:get, :post]
  match "/login_attempt" => "login#login_attempt", via: [:get, :post]
  #resources :trainingevents, only: [:new, :create]
  
end
