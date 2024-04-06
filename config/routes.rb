Rails.application.routes.draw do
  
  # mount ForestLiana::Engine => '/forest'
  require "sidekiq/web"
  mount Sidekiq::Web, at: "/sidekiq"
  # mount Intro::Engine => "/intro" #brainstaq.com/intro/admin
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: "home#index"
  
  resources :courses, except: [:edit] do
    get :purchased, :pending_review, :created, :unapproved, on: :collection
    resources :lessons do
      put :sort
      member do
        delete :delete_video
      end
    end
    resources :enrollments, only: [:new, :create, :index]
    member do
      get :analytics
      patch :approve
      patch :unapprove
    end
    resources :course_wizard, controller: 'courses/course_wizard'
  end

  resources :users, only: [:index, :edit, :show, :update]
  resources :youtube, only: :show
  resources :tags, only: [:create, :index, :destroy]
  resources :enrollments do
    get :my_students, on: :collection
    member do
      get :certificate
    end
  end
  
  get 'analytics', to: 'courses#analytics'

  namespace :charts do
    get 'users_per_day'
    get 'enrollments_per_day'
    get 'course_popularity'
    get 'money_makers'
  end

  get 'activity', to: 'courses#activity'

  resources :donors
  resources :follows
  resources :subscribers, only: [:create, :new, :index]
  resources :conversations do
    resources :messages
  end
  
  resources :subscription_plans
  
  resources :subscription_plans do
    post 'subscribe', on: :member
  end

  resources :subscription_plans do
    member do
      put :subscribe
    end
  end

  resources :donations
  resources :features
  # resources :contact, only: [:new, :create]

  resources :subscriptions, only: [:new, :create, :show, :edit, :update]

  post 'subscriptions/:id/subscribe', to: 'subscriptions#subscribe', as: 'subscribe'
  post 'subscriptions/:id/upgrade', to: 'subscriptions#upgrade', as: 'upgrade_subscription'
  post '/complete_subscription', to: 'subscriptions#complete'
  
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}, :controllers => {
    registrations: 'registrations',
    confirmations: 'confirmations',
    omniauth_callbacks: 'omniauth_callbacks'
  }
  
  # authenticate :user, lambda { |u| u.admin? } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end
  
  resources :enterprises, :path => 'brands', only: [:show, :index, :new, :create, :edit, :update, :destroy] do
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
  end

  resources :ideas, :path => 'projects', only: [:show, :index, :new, :create, :edit, :update, :destroy] do
    resources :comments
    member do
      put 'like', to: "ideas#like"
      put 'unlike', to: "ideas#unlike"
      get 'donation_history'
    end
  end
  post '/tinymce_assets' => 'tinymce_assets#create'
  # post "follow/user" => "users#follow_user", as: :follow_user
  # post  'check_recurring' => 'subscription_plans#check_recurring', as: :check_recurring
  # post  'check_selected_plan' => 'subscription_plans#check_selected_plan', as: :check_selected_plan

  post '/users/:username/follow', to: "users#follow", as: "follow_user"
  post '/users/:username/unfollow', to: "users#unfollow", as: "unfollow_user"

  get '/about' => 'pages#about'
  get '/pricing' => 'subscriptions#new'
  get '/career' => 'pages#career'
  get '/faqs' => 'pages#faqs'
  get '/all_features' => 'pages#features'
  get '/how_it_works' => 'pages#how_it_works'
  get '/contact' => 'pages#contact'
  get '/help' => 'pages#help'
  get '/the_academy' => 'courses#academy'
  get '/terms' => 'pages#terms'
  get '/privacy' => 'pages#privacy'

  get 'search' => 'search#index'

  get '/:username' => 'users#profile', as: :profile

  get '/user/:full_name' => 'users#dashboard', as: :dashboard

  # Routes for blog
  # match '/blog',        to: 'blog_posts#index', as: :blog_posts, via: :get
  # match '/blog/:title', to: 'blog_posts#show', as: :blog_post, via: :get

  resources :users, only: [:profile] do
    get :ideas
    get :enterprises
  end
  
  resources :users do
    resources :transactions
    member do
      get 'followings' => 'follows#following'
      get 'followers' => 'follows#follower'
    end
  end

  resource :session, only: [] do
    resource :name, only: :update, module: "sessions"
  end

  resources :retracts
  resources :transactions do
    member do
      get 'details'
    end
  end
  
  post 'web' => "retracts#web"
  get '/subscribe' => "subscriptions#handle_payments"
  get '/paystack_callback' => "subscriptions#paystack_callback"  

  post 'paystack/receive_webhooks', to: 'paystack#webhook'

end