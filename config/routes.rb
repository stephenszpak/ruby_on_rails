Rails.application.routes.draw do
  resources :posts do
    collection do
      get 'hobby'
      get 'study'
      get 'team'
    end
  end
  
  # Authentication routes
  devise_for :users, :controllers => { :registrations => "registrations" }
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end



  root to: 'pages#index'
end
