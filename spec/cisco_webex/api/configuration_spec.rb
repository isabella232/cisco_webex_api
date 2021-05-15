# frozen_string_literal: true

RSpec.describe CiscoWebex::Api::Configuration do
  describe '#base_uri' do
    it 'has a default value' do
      expect(CiscoWebex::Api::Configuration.new.base_uri).to be_a(String)
    end

    it 'can overwrite default value' do
      config = CiscoWebex::Api::Configuration.new
      config.base_uri = 'http://www.google.com'

      expect(config.base_uri).to eq 'http://www.google.com'
    end
  end
end
