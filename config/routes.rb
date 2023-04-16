# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :insurance_providers, param: :identifier do
        resources :customers, param: :identifier do
          resources :policies, param: :identifier do
            collection do
              get '/generate', action: :generate
            end

            member do
              patch '/quote', action: :quote
              patch '/activate', action: :activate
            end
          end
        end
      end
    end
  end
end
