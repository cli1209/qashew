Rails.application.routes.draw do
  
  	get '/home' => 'pages#home'
  	get '/index' => 'questions#index'
  	get '/explore' => 'pages#explore'
	get '/user/:id' => 'pages#profile'

  	devise_for :users

	resources :questions do
		resources :answers
	end
	
  	# define the root to go to questions if user is signed in, home otherwise
	authenticated :user do
	  root :to => "questions#index"
	end
	root :to => redirect("/home")

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
