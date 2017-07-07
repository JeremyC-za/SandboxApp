Rails.application.routes.draw do
  root 'welcome#index' # set welcome#index as the default page
  
  resources :welcome, only: [:index]
  resources :stripe
end
