# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :insurance_providers, param: :identifier do
        resources :customers, param: :identifier do
          resources :policies, param: :identifier
        end
      end
    end
  end
end
