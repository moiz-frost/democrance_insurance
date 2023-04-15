# frozen_string_literal: true

module Admin
  module Helpers
    module History
      def history_button(show_page, resource)
        path = public_send("history_admin_#{resource.model_name.singular_route_key}_path", resource) if resource.versions.exists?

        show_page.span do
          link = link_to('Audit History', path, { class: 'button' }) if path
          link || 'History for this entity is unavailable.'
        end
      end
    end
  end
end
