# frozen_string_literal: true

RSpec.describe CiscoWebex::Api::Meeting do
  it 'accepts access_token argument' do
    expect(CiscoWebex::Api::Meeting.new(access_token: '1234')).to be_instance_of(CiscoWebex::Api::Meeting)
  end

  describe '#create' do
    it 'creates a new meeting' do
      access_token = 1234
      meeting = CiscoWebex::Api::Meeting.new(access_token: access_token)
      uri = URI('https://webexapis.com/v1/meetings')

      expect(Net::HTTP).to receive(:post).with(
        uri,
        {
          title: 'Test api',
          start: '2021-05-15T15:37:39-04:00',
          end: '2021-05-15T16:37:52-04:00',
          enabledAutoRecordMeeting: false
        }.to_json,
        {
          "Authorization" => "Bearer #{access_token}",
          'Content-Type' => 'application/json'
        }
      )

      meeting.create(
        title: 'Test api',
        start_date_time: '2021-05-15T15:37:39-04:00',
        end_date_time: '2021-05-15T16:37:52-04:00'
      )
    end
  end
end
