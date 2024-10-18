Rails.application.routes.draw do
  root "boards#index"
  resources :boards, only: [:index, :new, :create, :show]
end
