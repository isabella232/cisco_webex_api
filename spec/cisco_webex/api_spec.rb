# frozen_string_literal: true

RSpec.describe CiscoWebex::Api do
  it "has a version number" do
    expect(CiscoWebex::Api::VERSION).not_to be nil
  end

  describe "#configure" do
    it "returns an overwritten base_uri" do
      CiscoWebex::Api.configure do |config|
        config.base_uri = "http://www.google.com"
      end

      expect(CiscoWebex::Api.configuration.base_uri).to eq "http://www.google.com"
    end
  end

  describe "#reset!" do
    it "reverts the configuration to the defaults" do
      CiscoWebex::Api.configure do |config|
        config.base_uri = "http://www.google.com/"
      end

      CiscoWebex::Api.reset!

      expect(CiscoWebex::Api.configuration.base_uri).to eq "https://webexapis.com/v1"
    end
  end
end
