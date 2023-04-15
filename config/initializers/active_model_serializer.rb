# frozen_string_literal: true

ActiveModelSerializers.config.adapter = :attributes

# Deep nesting association
ActiveModelSerializers.config.default_includes = '**'
