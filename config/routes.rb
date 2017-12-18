Rails.application.routes.draw do
  root to: 'pages#play'
  get 'admin' => 'pages#statistics', as: :statistics

  resources :recordings, only: [:index, :show, :destroy]
  resources :clips, only: [:new, :create, :destroy]

  # JSON API routes
  constraints lambda {|r| r.format == :json } do
    resources :clips, only: :index
    resources :recordings, only: [:index, :create, :show]
  end
end
