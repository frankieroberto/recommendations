ActionController::Routing::Routes.draw do |map|

  map.resources :users
  map.resource :session
  map.resources :users
  map.resources :taggings, :member => {:delete => :get}
  map.resources :tags, :requirements => {:id => /.+/}
  map.resources :recommendations, :collection => {:search => :get, :untagged => :get, :undescribed => :get, :unjustified => :get, :feed => :get}, :member => {:justification => :get} do |r|
    r.resources :descriptions
    r.resources :justifications
  end
  
  map.register '/register', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.homepage "", :controller => "homepage", :action => "index"

end
