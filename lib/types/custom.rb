# frozen_string_literal: true

module Types
  include Dry::Types()

  module Custom
    StrippedString = Types::Coercible::String.constructor(&:strip)
    StrippedDowncaseString = Types::Coercible::String.constructor { |value| value.strip.downcase }
  end
end
