Rails.application.routes.draw do
  root 'welcome#index'
  
  resources :welcome, only: [:index]

  resources :stripe, only: [:index] do
    collection do
      get :customers_index
      get :charges_index
      get :customers_new
      post :customers_create
    end
    member do
      get :customers_show
      get :customers_edit
      post :customers_save_card_details
      patch :customers_update
      get :charges_new
    end
  end

  resources :hands_on_table, only: [:index] do
    collection do
   	  get :display_table
    end
  end
end
