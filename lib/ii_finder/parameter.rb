# frozen_string_literal: true

module IIFinder
  class Parameter
    attr_accessor :name
    attr_accessor :options

    def initialize(name, options = {})
      @name = name
      @options = options
    end

    def allow_blank?
      @options[:allow_blank]
    end
  end
end
