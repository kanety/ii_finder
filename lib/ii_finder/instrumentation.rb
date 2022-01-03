# frozen_string_literal: true

module IIFinder
  module Instrumentation
    extend ActiveSupport::Concern

    def call_all
      ActiveSupport::Notifications.instrument 'calling.ii_finder', finder: self
      super
    end

    def call
      ActiveSupport::Notifications.instrument 'call.ii_finder', finder: self do
        super
      end
    end
  end
end
