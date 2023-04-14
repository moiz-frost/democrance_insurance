# frozen_string_literal: true

module Admin
  module Concerns
    module Auditable
      def self.included(resource_dsl)
        resource_class = resource_dsl.config.controller.resource_class

        raise "#{resource_class} doesn't support versions" unless resource_class.respond_to?(:version_class_name)

        resource_dsl.send(:member_action, :history) do
          @versions = resource.versions.reorder(created_at: :desc)
          render 'admin/shared/history'
        end

        resource_dsl.controller do
          helper Admin::Helpers::History
        end
      end
    end
  end
end
