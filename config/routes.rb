PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'

  get  '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get  '/logout', to: 'sessions#destory'

  resources :posts, except: :destory do
    member do
      post 'vote'     # /posts/:id/vote  => 'posts#vote'
    end

    resources :comments, only: :create do
      member do
        post 'vote'   # /posts/:post_id/comments/:id/vote  => 'comments#vote'
      end
    end  
  end
  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:create, :edit, :show, :update]
end
