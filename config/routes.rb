Rails.application.routes.draw do

  resources :users
  resources :reviews do
    resources :likes, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    '/login' => 'user_sessions#new', as: :login
  post   '/login' => 'user_sessions#create'
  delete '/logout' => 'user_sessions#destroy', as: :logout
  post   '/logout' => 'user_sessions#destroy'
  get    '/users/:id/edit' => 'users#edit'
  get    '/books/search' => 'books#search'
 
  # post   '/reviews/new' => 'reviews#new' 
  get '/reviews/:book_id/new' => 'reviews#new', as:'reviews_new'
  post '/reviews/:book_id/create' => 'reviews#create', as:'reviews_create'
  
  root 'user_sessions#index'
# root 'reviews#new'  
end
