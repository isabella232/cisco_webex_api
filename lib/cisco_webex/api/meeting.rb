# frozen_string_literal: true

require "net/http"
require "json"

module CiscoWebex
  module Api
    class Meeting
      def initialize(access_token:)
        @access_token = access_token
        @api_url = URI("#{CiscoWebex::Api.configuration.base_uri}/meetings/")
      end

      def create(title:, start_date_time:, end_date_time:, enabled_auto_record_meeting: false, **body_params)
        request_object = Net::HTTP::Post.new(@api_url).tap do |request|
          request["Content-Type"] = "application/json"
          request["Authorization"] = "Bearer #{@access_token}"
          request.body = {
            title: title,
            start: start_date_time,
            end: end_date_time,
            enabledAutoRecordMeeting: enabled_auto_record_meeting,
            **camelized_body_params(body_params)
          }.to_json
        end

        Net::HTTP.start(@api_url.hostname, @api_url.port, use_ssl: true) do |http|
          http.request(request_object)
        end
      end

      def update(meeting_id:, title:, password:, start_date_time:, end_date_time:, enabled_auto_record_meeting: false, **body_params)
        request_object = Net::HTTP::Put.new(@api_url + meeting_id).tap do |request|
          request["Content-Type"] = "application/json"
          request["Authorization"] = "Bearer #{@access_token}"
          request.body = {
            title: title,
            password: password,
            start: start_date_time,
            end: end_date_time,
            enabledAutoRecordMeeting: enabled_auto_record_meeting,
            **camelized_body_params(body_params)
          }.to_json
        end

        Net::HTTP.start(@api_url.hostname, @api_url.port, use_ssl: true) do |http|
          http.request(request_object)
        end
      end

      def delete(meeting_id:, **body_params)
        request_object = Net::HTTP::Delete.new(@api_url + meeting_id).tap do |request|
          request["Content-Type"] = "application/json"
          request["Authorization"] = "Bearer #{@access_token}"
          request.body = {
            **camelized_body_params(body_params)
          }.to_json
        end

        Net::HTTP.start(@api_url.hostname, @api_url.port, use_ssl: true) do |http|
          http.request(request_object)
        end
      end

      private

      def camelize(string)
        String(string).gsub(%r{(?:_|(/))([a-z\d]*)}i) { Regexp.last_match(2).capitalize.to_s }.to_sym
      end

      def camelized_body_params(body_params)
        body_params.transform_keys do |key|
          camelize(key)
        end
      end
    end
  end
end
