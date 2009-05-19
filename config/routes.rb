ActionController::Routing::Routes.draw do |map|

  map.login "/login", :controller => "sessions", :action => "new"
  map.logout "/logout", :controller => "sessions", :action => "destroy"
  map.forgot_password "/forgot_password", :controller => "user_password",
    :action => "forgot_password"
  map.reset_password "/reset_password/:login/:token",
    :controller => "user_password", :action => "reset_password", :method => "get"
  map.reset_password "/reset_password",
    :controller => "user_password", :action => "update_password", :method => "post"
  map.change_password "/change_password", :controller => "user_password",
    :action => "edit"

  map.resources :roles
  map.resources :sessions, :only => [:create]
  map.resources :users
  map.resources :user_roles, :only => [:edit, :update]
  map.resources :user_password, :only => [:edit, :update]

end
