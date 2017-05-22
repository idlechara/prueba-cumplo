Rails.application.routes.draw do
  resources :users
  get 'download/:id' => 'transferrals#download'
  resources :transferrals
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
