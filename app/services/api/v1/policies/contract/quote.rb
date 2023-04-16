# frozen_string_literal: true

module Api
  module V1
    module Policies
      module Contract
        class Quote < ApplicationContract
          json(Schema::Quote.new)
        end
      end
    end
  end
end
