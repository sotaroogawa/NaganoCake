Rails.application.routes.draw do
  root to: 'public/homes#top'
  scope module: 'public' do
    get '/about' => 'homes#about'
    get 'end_users/my_page' => 'end_users#show'
    get 'end_users/edit'
    patch 'end_users/update'
    get 'end_users/unsubscribe'
    patch 'end_users/withdraw'
    resources :items, only: [:index, :show]do
        get :search, on: :collection
    end
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete 'cart_items' => 'cart_items#destroy_all', as:'destroy_all'
    resources :addresses, only: [:index, :create, :new, :destroy]

    get 'orders/conclusion' => 'orders#conclusion'
    post 'orders/confirm'
    resources :orders, only: [:index, :new, :create, :show]
  end
  namespace :admin do
    root to: 'homes#top'
    get 'end_users' => 'end_users#index'
    resources :items, only: [:index, :show, :new, :create, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end
  devise_for :end_users,skip: [:passwords,], controllers: {
   sessions:      'end_users/sessions',
   registrations: 'end_users/registrations'
  }
  devise_for :admin,skip: [:passwords,], controllers: {
   sessions:      'admins/sessions',
  }
end
