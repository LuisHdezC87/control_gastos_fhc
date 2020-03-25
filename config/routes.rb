Rails.application.routes.draw do


  root 'projects#index'

  resources :projects do
    resources :categories do
      resources :products
    end
  end
  resources :contacts
  resources :incomes

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
