# frozen_string_literal: true

module ApiDocs
  module V1
    module InsuranceProviders
      extend Dox::DSL::Syntax

      document :api do
        resource 'InsuranceProviders' do
          endpoint '/insurance_provider'
          group 'InsuranceProviders'
        end
      end

      document :show do
        action 'Retrieve an insurance provider ' do
          desc 'insurance_providers/show.md'
        end
      end

      document :create do
        action 'Create an insurance provider' do
          desc 'insurance_providers/create.md'
        end
      end
    end
  end
end
