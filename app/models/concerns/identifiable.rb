# frozen_string_literal: true

module Identifiable
  extend ActiveSupport::Concern

  included do
    before_validation :set_identifier, if: ->(i) { i.identifier.blank? }
    validates :identifier, frozen: true, if: :id?
    validates :identifier, presence: true
  end

  class_methods do
    attr_reader :identifier_prefix, :identifier_length

    def identifier_options(prefix:, length: 16)
      ensure_prefix_uniqueness!(prefix)

      @identifier_prefix = prefix
      @identifier_length = length
    end

    private

    def ensure_prefix_uniqueness!(prefix)
      defined_prefixes = ObjectSpace.each_object(Class).select do |klass|
        klass.included_modules.include?(Identifiable)
      end.map(&:identifier_prefix)

      raise "Prefix #{prefix} is already defined" if defined_prefixes.include?(prefix)
    end
  end

  def set_identifier
    self.identifier = generate_identifier(self.class.identifier_prefix)
  end

  def generate_identifier(prefix)
    loop do
      token = [
        prefix,
        Array.new(self.class.identifier_length) { [*'0'..'9'].sample }.join
      ].join('-')
      break token unless self.class.exists?(identifier: token)
    end
  end
end
