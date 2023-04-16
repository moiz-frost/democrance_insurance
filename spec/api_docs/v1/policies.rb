# frozen_string_literal: true

module ApiDocs
  module V1
    module Policies
      extend Dox::DSL::Syntax

      document :api do
        resource 'Policies' do
          endpoint '/policies'
          group 'Policies'
        end
      end

      document :show do
        action 'Retrieve a policy' do
          desc 'policies/show.md'
        end
      end

      document :create do
        action 'Create a policy' do
          desc 'policies/create.md'
        end
      end

      document :list do
        action 'List policies' do
          desc 'policies/list.md'
        end
      end

      document :generate do
        action 'Generate policy' do
          desc 'policies/generate.md'
        end
      end

      document :quote do
        action 'Quote policy' do
          desc 'policies/quote.md'
        end
      end

      document :activate do
        action 'Activate policy' do
          desc 'policies/activate.md'
        end
      end
    end
  end
end
