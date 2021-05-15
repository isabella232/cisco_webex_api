require 'net/http'
require 'json'
require 'pry'

module CiscoWebex
  module Api
    class Meeting
      def initialize(access_token:)
        @access_token = access_token
        @api_url = URI(CiscoWebex::Api.configuration.base_uri + '/meetings')
      end

      def create(title:, start_date_time:, end_date_time:,enabled_auto_record_meeting: false, **body_params)
        Net::HTTP::post(
          @api_url,
          {
            title: title,
            start: start_date_time,
            end: end_date_time,
            enabledAutoRecordMeeting: enabled_auto_record_meeting,
            **camelized_body_params(body_params)
          }.to_json,
          {
            'Authorization' => "Bearer #{@access_token}",
            'Content-Type' => 'application/json'
          }
        )
      end

      def update(meeting_id:, title:, password:, start_date_time:, end_date_time:,enabled_auto_record_meeting: false, **body_params)
        # Net::HTTP::patch()
      end

      private

      def camelize(string)
        String(string).gsub(/(?:_|(\/))([a-z\d]*)/i) { "#{$2.capitalize}" }.to_sym
      end

      def camelized_body_params(body_params)
        body_params.transform_keys do |key|
          camelize(key)
        end
      end
    end
  end
end
