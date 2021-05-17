# frozen_string_literal: true

require_relative "api/version"
require_relative "api/configuration"
require_relative "api/client"
require_relative "api/meeting"
require_relative "api/utilities/request"

module CiscoWebex
  # The CiscoWebex API layer
  #
  # @author [joshuafrankel <josh@lessonly.com>]
  module Api
    class Error < StandardError; end

    class << self
      attr_writer :configuration

      # The current configuration
      #
      # @return [CiscoWebex::Api::configuration]
      def configuration
        @configuration ||= Configuration.new
      end

      # Enable block level configuration of the Api
      def configure
        yield(configuration)
      end

      # Reset configuration to default
      #
      # @return [CiscoWebex::Api::configuration]
      def reset!
        @configuration = Configuration.new
      end
    end
  end
end
