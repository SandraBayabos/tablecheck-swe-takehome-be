Rails.application.routes.draw do
  root to: redirect('/admin')
  
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
        get :current
        delete :delete
      end
    end
  end
end
