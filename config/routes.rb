Rails.application.routes.draw do
  root 'welcome#index'
  
  resources :welcome, only: [:index]
  resources :stripe, only: [:index]

  resources :hands_on_table, only: [:index] do
    collection do
   	  get :display_table
    end
  end
end
