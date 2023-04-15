# frozen_string_literal: true

require 'pagy/extras/items'

Pagy::DEFAULT[:items] = 50
Pagy::DEFAULT[:page_param] = :page
Pagy::DEFAULT[:items_param] = :per_page
Pagy::DEFAULT[:max_items] = 100
