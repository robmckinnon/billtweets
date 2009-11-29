ActionController::Routing::Routes.draw do |map|

  map.resources :entry_sources
  map.news_sources 'news_sources', :controller => 'entry_sources', :action => 'news_sources'
  map.blog_sources 'blog_sources', :controller => 'entry_sources', :action => 'blog_sources'
  map.parliament_sources 'parliament_sources', :controller => 'entry_sources', :action => 'parliament_sources'
  map.government_sources 'government_sources', :controller => 'entry_sources', :action => 'government_sources'

  map.resources :bills
  map.load_bills 'bills/load_bills', :controller => 'bills', :action => 'load_bills', :conditions => { :method => 'put' }

  map.resources :outgoing_tweets

  map.resources :tweets

  map.resources :tweeters, :except => :show
  map.make_tweets 'tweeters/:id/make_tweets', :controller => 'tweeters', :action => 'make_tweets'

  map.resources :news_items
  map.resources :news_queries
  map.do_search 'news_queries/:id/do_search', :controller => 'news_queries', :action => 'do_search'

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "application"
  map.tweeter ':id', :controller => 'tweeters', :action => 'show'
  map.tweeter_do_search ':id', :controller => 'tweeters', :action => 'do_search'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'


  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
end
