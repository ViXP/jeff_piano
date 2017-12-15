Rails.application.routes.draw do
  root to: 'statistics#show'
  get 'admin' => 'statistics#show', as: :statistics

  resources :recordings, except: [:new, :edit, :update]
  resources :clips, only: [:new, :create, :destroy]
end
