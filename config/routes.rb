Rails.application.routes.draw do
  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
  # get 'posts/edit'
  root to: "home#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :admins, skip: [:registrations]
  resources :categories
  resources :course_categories
  resources :posts
  # resources :skills

  # resources :business_ideas, only: [:new, :create, :index, :show]
  # resources :generated_ideas, only: [:show]
  
  # resources :courses
  resources :courses do
    resources :lessons do
      resources :comments, only: [:create, :destroy]
    end
    resources :course_wizard, controller: "courses/course_wizard"
  end

  # authenticated :admin_user do
  #   root to: "admin#index", as: :admin_root
  # end

  namespace :admin do
    resources :courses do
      resources :lessons
    end
    resources :users
  end

  get "admin" => "admin#index"

  patch "/admin/courses/:course_id/lessons/:id/move" => "admin/lessons#move"

  require "sidekiq/web"
  mount Sidekiq::Web, at: "/sidekiq"

  resources :transactions do
    member do
      get 'details'
    end
  end

  resources :users, only: [:index, :edit, :show, :update]
  resources :donors
  resources :follows
  resources :subscribers, only: [:create, :new, :index]
  resources :conversations do
    resources :messages
  end

  resources :subscription_plans
  resources :donations
  resources :features
  
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: {
    registrations: 'registrations',
    confirmations: 'confirmations',
    omniauth_callbacks: 'omniauth_callbacks'
  }

  resources :enterprises, path: 'brands', only: [:show, :index, :new, :create, :edit, :update, :destroy] do
    resources :pitch_decks
    resources :services
    resources :portfolios
    resources :invoices
    resources :business_plans, only: [:show, :index, :new, :create, :edit, :update, :financial_plan, :destroy] do
      get '/financial_plan' => 'business_plans#financials'
      get '/financial_plan/balance_sheet' => 'balance_sheet#show'
      get '/financial_plan/cash_flow_statement' => 'cash_flow_statement#show'
      get '/financial_plan/income_statement' => 'income_statement#show'
    end
    member do
      get 'activate_brand'
      get 'deactivate_brand'
    end
  end

  resources :ideas, path: 'projects', only: [:show, :index, :new, :create, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    member do
      put 'like', to: "ideas#like"
      put 'unlike', to: "ideas#unlike"
      get 'donation_history'
    end
  end

  
  resources :enrollments do
    get :teaching, on: :collection
    member do
      get :certificate
    end
  end

  resources :tags, only: [:create, :index, :destroy]
  resources :courses, except: [:edit] do
    get :learning, :pending_review, :teaching, :unapproved, on: :collection
    member do
      get :analytics
      patch :approve
    end

    resources :chapters, except: [:index, :show] do
      put :sort
    end

    resources :lessons, except: [:index] do
      resources :comments, except: [:index, :show, :new, :edit, :update]
      put :sort
      member do
        delete :delete_video
      end
    end
    resources :enrollments, only: [:new, :create]
  end
  resources :youtube, only: :show

  namespace :charts do
    get "users_per_day"
    get "enrollments_per_day"
    get "course_popularity"
    get "money_makers"
  end

  post '/tinymce_assets' => 'tinymce_assets#create'

  post '/users/:username/follow', to: "users#follow", as: "follow_user"
  post '/users/:username/unfollow', to: "users#unfollow", as: "unfollow_user"

  get '/about' => 'pages#about'
  get '/pricing' => 'transactions#new'
  get '/career' => 'pages#career'
  get '/faqs' => 'pages#faqs'
  get "activity", to: "pages#activity"
  get "analytics", to: "pages#analytics"
  get '/all_features' => 'pages#features'
  get '/how_it_works' => 'pages#how_it_works'
  get '/contact' => 'pages#contact'
  get '/help' => 'pages#help'
  get '/the_academy' => 'courses#index'
  get '/terms' => 'pages#terms'
  get '/privacy' => 'pages#privacy'
  get 'payment_history' => 'pages#payment_history'
  get 'search' => 'search#index'
  get '/user/:username' => 'users#profile', as: :profile

  post 'web' => 'retracts#web'
  get '/callback', to: 'transactions#callback', as: 'transaction_callback'
  get 'upgrade' => 'transactions#upgrade'

  post 'paystack/receive_webhooks', to: 'paystack#webhook'

  resources :users do
    member do
      get 'followings' => 'follows#following'
      get 'followers' => 'follows#follower'
    end
  end

  resource :session, only: [] do
    resource :name, only: :update, module: 'sessions'
  end

  resources :retracts

  get '/:full_name' => 'users#dashboard', as: :dashboard
end