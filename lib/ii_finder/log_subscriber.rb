# frozen_string_literal: true

module IIFinder
  class LogSubscriber < ActiveSupport::LogSubscriber
    def calling(event)
      debug do
        finder = event.payload[:finder]
        "Calling #{finder.class} with #{finder.context}"
      end
    end

    def call(event)
      debug do
        finder = event.payload[:finder]
        "Called #{finder.class} (#{additional_log(event)})"
      end
    end

    private

    def additional_log(event)
      additions = ["Duration: %.1fms" % event.duration]
      additions << "Allocations: %d" % event.allocations if event.respond_to?(:allocations)
      additions.join(', ')
    end
  end
end
