Rails.application.routes.draw do
  root "boards#new"
  resources :boards, only: [:index, :new, :create, :show]
end
