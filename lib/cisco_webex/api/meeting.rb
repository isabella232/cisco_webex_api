# frozen_string_literal: true

require "json"

module CiscoWebex
  module Api
    # The Meeting Api endpoint wrapper
    class Meeting
      def initialize(access_token:)
        @access_token = access_token
        @api_url = "#{CiscoWebex::Api.configuration.base_uri}/meetings/"
      end

      def create(
        title:,
        start_date_time:,
        end_date_time:,
        enabled_auto_record_meeting: false,
        **body_params
      )
        request
          .post(
            uri: @api_url,
            title: title,
            start: start_date_time,
            end: end_date_time,
            enabledAutoRecordMeeting: enabled_auto_record_meeting,
            **body_params
          )
      end

      def update(
        meeting_id:,
        title:,
        password:,
        start_date_time:,
        end_date_time:,
        enabled_auto_record_meeting: false,
        **body_params
      )
        request
          .put(
            uri: @api_url + meeting_id,
            title: title,
            password: password,
            start: start_date_time,
            end: end_date_time,
            enabledAutoRecordMeeting: enabled_auto_record_meeting,
            **body_params
          )
      end

      def delete(meeting_id:, **body_params)
        request
          .delete(
            uri: @api_url + meeting_id,
            **body_params
          )
      end

      private

      def request
        Utilities::Request.new(access_token: @access_token)
      end
    end
  end
end
