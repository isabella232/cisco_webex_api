module CiscoWebex
  module Api
    class Client
      def initialize(access_token:)
        @access_token = access_token
      end

      def meetings
        CiscoWebex::Api::Meeting.new(access_token: access_token)
      end
    end
  end
end
