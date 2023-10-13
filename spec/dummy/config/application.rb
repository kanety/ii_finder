require_relative 'boot'

require "active_record/railtie"
require "active_job/railtie"

Bundler.require(*Rails.groups)
require "ii_finder"

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f if config.respond_to?(:load_defaults)

    config.after_initialize do
      IIFinder::LogSubscriber.attach_to(:ii_finder)
    end
  end
end
