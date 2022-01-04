# frozen_string_literal: true

module IIFinder
  class Context < Coactive::Context
    def to_s
      "#<#{self.class} model=#{@_data[:model]} criteria=#{@_data[:criteria].to_s.truncate(300)}>"
    end
  end
end
