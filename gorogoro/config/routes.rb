Rails.application.routes.draw do
  get 'new', :to => 'credit_transfers#new'
  post 'new', :to => 'credit_transfers#create'

  root :to => 'credit_transfers#index'

  # get 'credit_transfer/get_details'
  #
  # get 'credit_transfer/add_document'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
