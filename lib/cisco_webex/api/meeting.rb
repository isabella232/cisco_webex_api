require 'net/http'
require 'json'
require 'pry'

module CiscoWebex
  module Api
    class Meeting
      def initialize(access_token:)
        @access_token = access_token
      end

      def create(title:, start_date_time:, end_date_time:, enabled_auto_record_meeting: false)
        uri = URI('https://webexapis.com/v1/meetings')

        response = Net::HTTP::post(
          uri, {
            title: title,
            start: start_date_time,
            end: end_date_time,
            enabledAutoRecordMeeting: enabled_auto_record_meeting
          }.to_json,
          {
            'Authorization' => "Bearer #{@access_token}",
            'Content-Type' => 'application/json'
          }
        )
      end
    end
  end
end
