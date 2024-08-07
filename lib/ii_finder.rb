# frozen_string_literal: true

require 'active_support'
require 'coactive'

require 'ii_finder/version'
require 'ii_finder/config'
require 'ii_finder/errors'
require 'ii_finder/base'
require 'ii_finder/scope'
require 'ii_finder/log_subscriber'
require 'ii_finder/railtie' if defined?(Rails)

module IIFinder
  class << self
    def configure
      yield Config
    end

    def config
      Config
    end
  end
end
