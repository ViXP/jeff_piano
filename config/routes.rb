Rails.application.routes.draw do
  root to: 'pages#play'
  get 'admin' => 'pages#statistics', as: :statistics

  resources :recordings, except: [:new, :edit, :update]
  resources :clips, only: [:new, :create, :destroy]
end
