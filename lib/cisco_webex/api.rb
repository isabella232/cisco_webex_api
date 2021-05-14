# frozen_string_literal: true

require_relative "api/version"
require_relative "api/client"
require_relative "api/meeting"

module CiscoWebex
  module Api
    class Error < StandardError; end
  end
end
