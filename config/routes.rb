Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope 'api' do
    resources :drinks do
      resources :ingredients, only: [:create]
    end

    resources :ingredients, only: [:update,:destroy]
  end
end
