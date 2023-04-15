# frozen_string_literal: true

module Api
  module V1
    module Concerns
      module Paginatable
        extend ActiveSupport::Concern

        included do
          include Pagy::Backend

          private

          def pagination_meta(pagy)
            {
              per_page: pagy.items,
              current_page: pagy.page,
              next_page: pagy.next,
              prev_page: pagy.prev,
              total_pages: pagy.pages,
              total_count: pagy.count
            }
          end
        end
      end
    end
  end
end
