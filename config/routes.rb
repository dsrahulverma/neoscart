Rails.application.routes.draw do
	
	get 'users/thanks'
	
	resources :products, only: [:index]
	resource :cart, only: [:show]
	resources :order_items, only: [:create, :update, :destroy]
	resources :order_promotions, only: [:create, :destroy]
	resources :users, only: [:new, :create, :thanks]
  
	root to: "products#index"
end