Rails.application.routes.draw do
  root 'welcome#index'
  
  resources :welcome, only: [:index]
  
  resources :break_the_rules, only: [:index]
  resources :break_the_rules_event do
    member do
      get :download_csv
    end
    resources :break_the_rules_applicant do
      member do
        get :thank_you
      end
    end
  end
  
  resources :bootstrap, only: [:index]

  resources :stripe, only: [:index]
  resources :stripe_charge, only: [:index]
  resources :stripe_customer do
    member do
      post :save_card_details
      get :view_all_charges
    end
    resources :stripe_charge, only: [:show, :new, :create]
  end

  resources :hands_on_table, only: [:index] do
    collection do
   	  get :display_table
    end
  end
end
