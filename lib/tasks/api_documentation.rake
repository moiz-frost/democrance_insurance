# frozen_string_literal: true

# :nocov:
if Rails.env.in? %w[development test]
  namespace :api do
    namespace :doc do
      # rake api:doc:md\[v1\]
      desc 'Generate API documentation markdown'
      task :md, [:version] => [:environment] do |_task, params|
        version = params.version # v1

        raise "API version #{version} is not available" if %(v1).exclude?(version)

        require 'rspec/core/rake_task'

        apidoc_path = Rails.root.join('docs', 'api', version, 'apidoc.json')

        RSpec::Core::RakeTask.new(:api_spec) do |t|
          t.pattern = "spec/requests/api/#{version}/"
          t.rspec_opts = "-f Dox::Formatter --order defined --tag dox --out #{apidoc_path} --require rails_helper"
        end

        Rake::Task['api_spec'].invoke
      end

      # rake api:doc:html\[v1\]
      desc 'Generate API documentation html'
      task :html, [:version] => [:environment] do |_task, params|
        # Need to install snowboard v3.7.5, as v4 doesn't generate static html
        raise('redoc-cli is not installed on your system') unless system('redoc-cli --version')

        version = params.version
        Rake::Task['api:doc:md'].invoke(version)

        path = Rails.root.join('docs', 'api', version)
        system("redoc-cli bundle -o #{path}/apidoc.html #{path}/apidoc.json")
      end
    end
  end
end
# :nocov:
