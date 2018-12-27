Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #get 'home/index'
  #root to: 'home#index'
  get 'home/show'
  root to: 'home#show'
  devise_for :users, controllers: {
                                    registrations: 'users/registrations',
                                    :omniauth_callbacks => "users/omniauth_callbacks"
                                  }
  resource :profile, only: [:show, :update]


  resources :items do
    resources :ratings
    collection do
      get :meetup
      get :borrowed_index #borrowed items
      get :lent_index #borrowed items
      get :history_index
      get :get_image_attachment
    end
    member do
      get :qrcode
      delete :delete_image_attachment
    end
  end

  resources :friends
  resources :categories
  resources :transactions do# for debugging purposes

    resources :uratings do
      collection do
        get :new_lender_rating
        post :create_lender_rating
        get :new_borrower
        post :create_borrower_rating
      end
    end
    collection do
      post :create_meetup
      delete :delete_all
    end
    member do
      # post :meetup_accept
      put :request_accept
      put :request_reject
      put :request_cancel
      put :meetup_success
      put :return_success
      delete :delete_image_attachment
    end
  end
  resources :marketplaces

  resource :dashboard
  resource :landing
  resources :announcements  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/pages/:page" => "pages#show"
  get "urating" => "uratings#index_user"

  namespace 'api' do
    resources :categories
    resources :friends
    resources :items
    resources :ratings
    resources :transactions
    resources :uratings
  end
end
