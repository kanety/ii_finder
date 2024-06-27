# frozen_string_literal: true

module IIFinder
  module Instrumentation
    extend ActiveSupport::Concern

    def call_all
      ActiveSupport::Notifications.instrument 'start_call_all.ii_finder', finder: self
      super
    end

    def call
      ActiveSupport::Notifications.instrument 'process_call.ii_finder', finder: self do
        super
      end
    end
  end
end
