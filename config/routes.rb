Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  begin
    ActiveAdmin.routes(self)
  rescue StandardError
    ActiveAdmin::DatabaseHitDuringLoad
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    resources :parties, only: %i[create] do
      collection do
        put :check_in
      end
    end
  end
end
