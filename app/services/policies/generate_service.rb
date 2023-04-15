# frozen_string_literal: true

module Policies
  class GenerateService
    BASE_PREMIUM_CENTS = 100_000
    MAX_COVER_PERCENT = 0.3
    MAX_PREMIUM_DISCOUNT_PERCENT = 0.2

    def initialize(insurance_provider_identifier:, customer_identifier:)
      super()
      @insurance_provider_identifier = insurance_provider_identifier
      @customer_identifier = customer_identifier
    end

    def call
      policies = customer.policies
      customer_age = customer.age
      customer_currency = customer.currency

      base_premium = Money.new(BASE_PREMIUM_CENTS, customer_currency)

      discount_rate = if policies.count.positive?
                        [policies.count.to_f / 100, MAX_PREMIUM_DISCOUNT_PERCENT].min
                      else
                        1
                      end
      premium_multiplier = 1 + (customer_age.to_f / 100)

      total_premium = base_premium * premium_multiplier * discount_rate

      base_cover_cents = total_premium * MAX_COVER_PERCENT
      base_cover = Money.new(base_cover_cents, customer_currency)

      Policy.new(premium: total_premium, cover: base_cover)
    end

    private

    attr_reader :insurance_provider_identifier, :customer_identifier

    def customer
      @customer ||= Customer.joins(:insurance_provider)
                            .where(InsuranceProvider.arel_table[:identifier].eq(insurance_provider_identifier))
                            .find_by!(identifier: customer_identifier)
    end
  end
end
