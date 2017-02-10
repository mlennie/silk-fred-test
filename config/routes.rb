Rails.application.routes.draw do

  root to: 'documents#index'
  resources :documents, only: [:index, :create, :show]

  get '/montages/:id', to: 'documents#get_montage'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
