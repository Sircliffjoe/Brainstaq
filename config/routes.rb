# Rails.application.routes.draw do
#   # mount ForestLiana::Engine => '/forest'
#   require "sidekiq/web"
#   mount Sidekiq::Web, at: "/sidekiq"
#   # mount Intro::Engine => "/intro" #brainstaq.com/intro/admin
#   # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

#   root to: "home#index"

#   resources :transactions
#   resources :transactions do
#     member do
#       get 'details'
#     end
#   end

#   resources :users, only: [:index, :edit, :show, :update]
#   resources :donors
#   resources :follows
#   resources :subscribers, only: [:create, :new, :index]
#   resources :conversations do
#     resources :messages
#   end
  
#   resources :subscription_plans
#   resources :donations
#   resources :features
  
#   devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}, :controllers => {
#     registrations: 'registrations',
#     confirmations: 'confirmations',
#     omniauth_callbacks: 'omniauth_callbacks'
#   }
  
#   resources :enterprises, :path => 'brands', only: [:show, :index, :new, :create, :edit, :update, :destroy] do
#     resources :pitch_decks
#     resources :services
#     resources :portfolios
#     resources :invoices
#     resources :business_plans, only: [:show, :index, :new, :create, :edit, :update, :financial_plan, :destroy] do
#       get '/financial_plan' => 'business_plans#financials'
#       get '/financial_plan/balance_sheet' => 'balance_sheet#show'
#       get '/financial_plan/cash_flow_statement' => 'cash_flow_statement#show'
#       get '/financial_plan/income_statement' => 'income_statement#show'
#     end
#     member do
#       get 'activate_enterprise'
#       get 'deactivate_enterprise'
#     end
#   end

#   resources :ideas, :path => 'projects', only: [:show, :index, :new, :create, :edit, :update, :destroy] do
#     resources :comments
#     member do
#       put 'like', to: "ideas#like"
#       put 'unlike', to: "ideas#unlike"
#       get 'donation_history'
#     end
#   end
#   post '/tinymce_assets' => 'tinymce_assets#create'

#   post '/users/:username/follow', to: "users#follow", as: "follow_user"
#   post '/users/:username/unfollow', to: "users#unfollow", as: "unfollow_user"

#   get '/about' => 'pages#about'
#   get '/pricing' => 'transactions#new'
#   get '/career' => 'pages#career'
#   get '/faqs' => 'pages#faqs'
#   get '/all_features' => 'pages#features'
#   get '/how_it_works' => 'pages#how_it_works'
#   get '/contact' => 'pages#contact'
#   get '/help' => 'pages#help'
#   get '/the_academy' => 'courses#academy'
#   get '/terms' => 'pages#terms'
#   get '/privacy' => 'pages#privacy'
#   get 'payment_history' => 'pages#payment_history'
#   get 'search' => 'search#index'
#   get '/user/:username' => 'users#profile', as: :profile
#   get '/:full_name' => 'users#dashboard', as: :dashboard

#   post 'web' => "retracts#web"
#   get '/callback', to: 'transactions#callback', as: 'transaction_callback'
#   get 'upgrade' => "transactions#upgrade"

#   post 'paystack/receive_webhooks', to: 'paystack#webhook'
  
#   resources :users do
#     member do
#       get 'followings' => 'follows#following'
#       get 'followers' => 'follows#follower'
#     end
#   end

#   resource :session, only: [] do
#     resource :name, only: :update, module: "sessions"
#   end

#   resources :retracts
# end



Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web, at: "/sidekiq"
  
  root to: "home#index"

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
    resources :comments
    member do
      put 'like', to: "ideas#like"
      put 'unlike', to: "ideas#unlike"
      get 'donation_history'
    end
  end

  post '/tinymce_assets' => 'tinymce_assets#create'

  post '/users/:username/follow', to: "users#follow", as: "follow_user"
  post '/users/:username/unfollow', to: "users#unfollow", as: "unfollow_user"

  get '/about' => 'pages#about'
  get '/pricing' => 'transactions#new'
  get '/career' => 'pages#career'
  get '/faqs' => 'pages#faqs'
  get '/all_features' => 'pages#features'
  get '/how_it_works' => 'pages#how_it_works'
  get '/contact' => 'pages#contact'
  get '/help' => 'pages#help'
  get '/the_academy' => 'courses#academy'
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