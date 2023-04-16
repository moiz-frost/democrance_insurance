# frozen_string_literal: true

require 'dox'

RSpec.configure do |config|
  config.after(:each, :dox) do |example|
    example.metadata[:request] = request
    example.metadata[:response] = response

    # This is a workaround to allow docs generation for several versions using rake task.
    unless Dox.config.header_description
      version = request.path.match(%r{/api/v.}).to_s.last(2)
      Dox.configure do |conf|
        conf.header_description = 'header.md'
        conf.descriptions_location = Rails.root.join("spec/api_docs/#{version}/descriptions").to_s
        conf.api_version = version
      end
    end
  end
end

Dox.configure do |config|
  config.headers_whitelist = %w[Accept Content-Type]
end
