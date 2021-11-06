# frozen_string_literal: true

require_relative 'core'
require_relative 'parameters'
require_relative 'callbacks'
require_relative 'instrumentation'
require_relative 'lookup'
require_relative 'chain'

module IIFinder
  class Base
    include Core
    include Parameters
    include Callbacks
    include Instrumentation
    include Lookup
    include Chain
  end
end
