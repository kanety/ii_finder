# frozen_string_literal: true

module IIFinder
  class Railtie < Rails::Railtie
    ActiveSupport::Reloader.to_prepare do
      IIFinder::Lookup.cache.clear
    end
  end
end
