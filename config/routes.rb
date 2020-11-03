Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'cities#index'
  get 'cities', to: 'cities#index'
  get 'cities/search', to: 'cities#search'
  get 'cities/:name', to: 'cities#show', as: 'city'
end
