# frozen_string_literal: true

RSpec::Matchers.define :match_json_string_schema do |schema|
  match do |json_string|
    @result = schema.call(JSON.parse(json_string))
    @result.success?
  end

  def failure_message
    @result.errors.to_h
  end
end
