require 'active_support'

require 'ii_finder/version'
require 'ii_finder/config'
require 'ii_finder/errors'
require 'ii_finder/base'
require 'ii_finder/scope'

module IIFinder
  class << self
    def configure
      yield Config
    end
  end
end
