# frozen_string_literal: true

module CiscoWebex
  module Api
    # The Client interface for working with the Api
    class Client
      def initialize(access_token:)
        @access_token = access_token
      end

      # Client delegation to the Meeting Api
      #
      # @return [CiscoWebex::Api::Meeting]
      def meetings
        CiscoWebex::Api::Meeting.new(access_token: @access_token)
      end
    end
  end
end
