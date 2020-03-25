Rails.application.routes.draw do


  root 'projects#index'

  resources :projects do
    resources :categories do
      resources :products
    end

    resources :bill_types
    resources :incomes

    resources :bills do
      resources :bill_rows
    end
  end

  resources :contacts

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
