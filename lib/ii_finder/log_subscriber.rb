# frozen_string_literal: true

module IIFinder
  class LogSubscriber < ActiveSupport::LogSubscriber
    def start_call_all(event)
      debug do
        finder = event.payload[:finder]
        "  Calling #{finder.class} with #{finder.context}"
      end
    end

    def process_call(event)
      debug do
        finder = event.payload[:finder]
        "  Called #{finder.class} (#{additional_log(event)})"
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
