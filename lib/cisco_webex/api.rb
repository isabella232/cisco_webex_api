# frozen_string_literal: true

require_relative "api/version"
require_relative "api/configuration"
require_relative "api/client"
require_relative "api/meeting"

module CiscoWebex
  module Api
    class Error < StandardError; end

    class << self
      attr_writer :configuration

      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end

      def reset!
        @configuration = Configuration.new
      end
    end
  end
end
