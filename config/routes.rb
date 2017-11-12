Rails.application.routes.draw do
  
  	get '/home' => 'pages#home'
  	get '/index' => 'questions#index'
  	get '/explore' => 'pages#explore'
	get '/user/:id' => 'pages#profile'

  	devise_for :users

	  resources :questions do
	  	resources :answers
		put "upvote", to: "questions#upvote"
		put "downvote", to: "questions#downvote"
		put "undoupvote", to: "questions#undoupvote"
		put "undodownvote", to: "questions#undodownvote"
	end

	resources :answers do
		resources :questions
		put "upvote", to: "answers#upvote"
		put "downvote", to: "answers#downvote"
		put "undoupvote", to: "answers#undoupvote"
		put "undodownvote", to: "answers#undodownvote"
	end

  	# define the root to go to questions if user is signed in, home otherwise
	authenticated :user do
	  root :to => "questions#index"
	end
	root :to => redirect("/home")

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
