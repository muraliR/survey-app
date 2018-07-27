Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :surveys

  resources :questions do 
  	member do
  		get :add
  		post :create_question
  		delete :detroy_question
  	end
  end
end
