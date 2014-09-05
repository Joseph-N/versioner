Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'home#index'
  end

  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  resources :organisations do
    resources :articles do
      resources :attachments
    end
  end
end
