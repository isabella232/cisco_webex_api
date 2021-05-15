# frozen_string_literal: true

RSpec.describe CiscoWebex::Api::Meeting do
  it 'accepts access_token argument' do
    expect(CiscoWebex::Api::Meeting.new(access_token: '1234')).to be_instance_of(CiscoWebex::Api::Meeting)
  end

  describe '#create' do
    it 'creates a new meeting' do
      access_token = 1234
      response_password = "329vFh32d"
      meeting = CiscoWebex::Api::Meeting.new(access_token: access_token)
      uri = URI('https://webexapis.com/v1/meetings')

      expect(Net::HTTP).to receive(:post).with(
        uri,
        {
          title: 'Test api',
          start: '2021-05-15T15:37:39-04:00',
          end: '2021-05-15T16:37:52-04:00',
          enabledAutoRecordMeeting: false,
          timezone: "PDT",
          sendEmail: true
        }.to_json,
        {
          "Authorization" => "Bearer #{access_token}",
          'Content-Type' => 'application/json'
        }
      ).and_return(
        body: {
          "id": "123456",
          "meetingNumber": "984",
          "title": "Future Meeting by consumer",
          "password": response_password,
          "phoneAndVideoSystemPassword": "329vFh32d",
          "meetingType": "meetingSeries",
          "state": "active",
          "timezone": "UTC",
          "start": "2021-05-20T19:37:39Z",
          "end": "2021-05-20T20:37:39Z",
          "hostUserId": "fjioewfH398hf3hGfjofoobar",
          "hostDisplayName": "Josh F",
          "hostEmail": "josh-organizer@some_company.com",
          "hostKey": "foobar",
          "siteUrl": "meet76.webex.com",
          "webLink": "https://meet76.webex.com/meet76/j.php?MTID=329vFh32d",
          "sipAddress": "foobar@meet76.webex.com",
          "dialInIpAddress": "192.168.0.1",
          "enabledAutoRecordMeeting": false,
          "allowAuthenticatedDevices": false,
          "enabledJoinBeforeHost": true,
          "joinBeforeHostMinutes": 5,
          "enableConnectAudioBeforeHost": true,
          "telephony": {
            "accessCode": "foobar",
            "callInNumbers": [],
            "links": [
              {
                "rel": "globalCallinNumbers",
                "href": "/v1/meetings/123456/globalCallinNumbers",
                "method": "GET"
              }
            ]
          },
          "excludePassword": false,
          "publicMeeting": false
        }.to_json
      )

      response = meeting.create(
        title: 'Test api',
        start_date_time: '2021-05-15T15:37:39-04:00',
        end_date_time: '2021-05-15T16:37:52-04:00',
        timezone: "PDT",
        send_email: true
      )

      expect(JSON.parse(response[:body])["password"]).to eq response_password
    end

    it 'fails when missing required body parameters' do
      access_token = 1234
      meeting = CiscoWebex::Api::Meeting.new(access_token: access_token)
      uri = URI('https://webexapis.com/v1/meetings')

      expect(Net::HTTP).to receive(:post).and_return(Net::HTTPBadRequest.new('1.1', 400, "Bad Request"))

      meeting.create(
        title: nil,
        start_date_time: nil,
        end_date_time: nil,
        timezone: "PDT",
        send_email: true
      )
    end
  end

  describe '#update' do
    it 'updates an existing meeting' do
      access_token = 1234
      response_password = "329vFh32d"
      meeting = CiscoWebex::Api::Meeting.new(access_token: access_token)
      uri = URI('https://webexapis.com/v1/meetings')

      meeting.update(
        meeting_id: 1234,
        title: 'Hello',
        password: '12345678',
        start_date_time: '2021-05-15T15:37:39-04:00',
        end_date_time: '2021-05-15T16:37:52-04:00'
      )
    end
  end
end
