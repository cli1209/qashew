Rails.application.routes.draw do
  
  	get '/home' => 'pages#home'
  	get '/explore' => 'pages#explore'
	get '/user/:id' => 'pages#profile'

  	devise_for :users
  	# define the root to go to questions 
	root to: 'questions#index'
	resources :questions

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
