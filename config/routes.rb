Rails.application.routes.draw do
  devise_for :users
  root to: 'authentications#home'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :frases, only: [ :show ]
    end
  end
end