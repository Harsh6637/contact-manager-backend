Rails.application.routes.draw do
  resources :contacts, only: [:index, :create, :destroy]
  get 'contacts/search/:query', to: 'contacts#search'
end
