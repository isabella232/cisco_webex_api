# frozen_string_literal: true

require "net/http"

module CiscoWebex
  module Api
    module Utilities
      # Net::HTTP Request wrapper
      class Request
        def initialize(access_token:)
          @access_token = access_token
        end

        # Post request
        # @param uri: [String|URI] The URI to call
        # @param **body_params [Hash] The body parameters to send
        #
        # @return [Response]
        def post(uri:, **body_params)
          request_object = Net::HTTP::Post.new(URI.parse(uri)).tap do |request|
            request["Content-Type"] = "application/json"
            request["Authorization"] = "Bearer #{@access_token}"
            request.body = {
              **camelized_body_params(body_params)
            }.to_json
          end

          Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(request_object)
          end
        end

        # Put request
        # @param uri: [String|URI] The URI to call
        # @param **body_params [Hash] The body parameters to send
        #
        # @return [Response]
        def put(uri:, **body_params)
          request_object = Net::HTTP::Put.new(URI.parse(uri)).tap do |request|
            request["Content-Type"] = "application/json"
            request["Authorization"] = "Bearer #{@access_token}"
            request.body = {
              **camelized_body_params(body_params)
            }.to_json
          end

          Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(request_object)
          end
        end

        # Delete request
        # @param uri: [String|URI] The URI to call
        # @param **body_params [Hash] The body parameters to send
        #
        # @return [Response]
        def delete(uri:, **body_params)
          request_object = Net::HTTP::Delete.new(URI.parse(uri)).tap do |request|
            request["Content-Type"] = "application/json"
            request["Authorization"] = "Bearer #{@access_token}"
            request.body = {
              **camelized_body_params(body_params)
            }.to_json
          end

          Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
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
end
