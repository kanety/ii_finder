# frozen_string_literal: true

require_relative 'core'
require_relative 'parameters'
require_relative 'callbacks'
require_relative 'lookup'

module IIFinder
  class Base
    include Core
    include Parameters
    include Callbacks
    include Lookup
  end
end
