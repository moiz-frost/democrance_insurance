# frozen_string_literal: true

module Admin
  module Concerns
    module Discardable
      def self.included(base)
        base.instance_eval do
          controller do
            def destroy
              if resource.discard
                flash[:notice] = t('admin.discard.deleted')
              else
                flash[:alert] = resource.errors.full_messages.to_sentence
              end

              redirect_to smart_resource_url
            end
          end

          member_action :undiscard, method: :patch do
            if resource.undiscard
              flash[:notice] = t('admin.discard.restored')
            else
              flash[:alert] = resource.errors.full_messages.to_sentence
            end

            redirect_to smart_resource_url
          end
        end
      end
    end
  end
end
