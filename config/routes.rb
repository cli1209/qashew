Rails.application.routes.draw do
  
  get 'notifications/link_through'
  	get '/home' => 'pages#home'
  	get '/index' => 'questions#index'
  	get '/privacy' => "pages#privacy"
	get '/user/:id' => 'pages#profile'
	get '/tag/:tag_id' => 'pages#tag', as: :tag
	get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through
	get 'notifications/:id/view_all', to: 'notifications#view_all',
								        as: :view_all

  	devise_for :users

	resources :questions do
	  	resources :answers
		put "upvote", to: "questions#upvote"
		put "downvote", to: "questions#downvote"
		put "undoupvote", to: "questions#undoupvote"
		put "undodownvote", to: "questions#undodownvote"
		put "star", to: "questions#star"
		put "unstar", to: "questions#unstar"
		put "resolved", to: "questions#resolved"
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
	# catch any undefined routes and redirect to root page
	
	get '*path' => redirect('/')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
