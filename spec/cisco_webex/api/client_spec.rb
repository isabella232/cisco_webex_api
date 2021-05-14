# frozen_string_literal: true

RSpec.describe CiscoWebex::Api::Client do
  it "accepts access_token argument" do
    expect(CiscoWebex::Api::Client.new(access_token: "1234")).to be_instance_of(CiscoWebex::Api::Client)
  end

  describe "#meetings" do
    it ""
  end
end
