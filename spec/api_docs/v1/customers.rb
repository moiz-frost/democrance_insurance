# frozen_string_literal: true

module ApiDocs
  module V1
    module Customers
      extend Dox::DSL::Syntax

      document :api do
        resource 'Customers' do
          endpoint '/customers'
          group 'Customers'
        end
      end

      document :show do
        action 'Retrieve a customer' do
          desc 'customers/show.md'
        end
      end

      document :create do
        action 'Create a customer' do
          desc 'customers/create.md'
        end
      end

      document :list do
        action 'List customers' do
          desc 'customers/list.md'
        end
      end
    end
  end
end
