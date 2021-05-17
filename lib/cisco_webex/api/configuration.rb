# frozen_string_literal: true

module CiscoWebex
  module Api
    # The Configuration utilized throughout the gem
    class Configuration
      attr_accessor :base_uri

      def initialize
        @base_uri = "https://webexapis.com/v1"
      end
    end
  end
end
