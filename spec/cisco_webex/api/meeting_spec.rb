# frozen_string_literal: true

RSpec.describe CiscoWebex::Api::Meeting do
  let(:access_token) { 1234 }
  let(:password) { "329vFh32d" }
  let(:meeting) { CiscoWebex::Api::Meeting.new(access_token: access_token) }
  let(:uri) { URI("https://webexapis.com/v1/meetings/") }

  it "accepts access_token argument" do
    expect(CiscoWebex::Api::Meeting.new(access_token: "1234")).to be_instance_of(CiscoWebex::Api::Meeting)
  end

  describe "#create" do
    it "creates a new meeting" do
      stub_request(:post, uri)
        .with(
          body: {
            title: "Test api",
            start: "2021-05-15T15:37:39-04:00",
            end: "2021-05-15T16:37:52-04:00",
            enabledAutoRecordMeeting: false,
            timezone: "PDT",
            sendEmail: true
          }.to_json,
          headers: {
            "Authorization" => "Bearer #{access_token}",
            "Content-Type" => "application/json"
          }
        ).to_return(body: successful_response)

      response = meeting.create(
        title: "Test api",
        start_date_time: "2021-05-15T15:37:39-04:00",
        end_date_time: "2021-05-15T16:37:52-04:00",
        timezone: "PDT",
        send_email: true
      )

      expect(JSON.parse(response.body)["password"]).to eq password
    end

    it "fails when missing required body parameters" do
      stub_request(:post, uri)
        .with(
          body: {
            title: nil,
            start: nil,
            end: nil,
            enabledAutoRecordMeeting: false,
            timezone: "PDT",
            sendEmail: true
          }.to_json,
          headers: {
            "Authorization" => "Bearer #{access_token}",
            "Content-Type" => "application/json"
          }
        ).to_return(bad_request)

      meeting.create(
        title: nil,
        start_date_time: nil,
        end_date_time: nil,
        timezone: "PDT",
        send_email: true
      )
    end
  end

  describe "#update" do
    it "updates an existing meeting" do
      meeting_id = "1234"
      stub_request(:put, uri + meeting_id)
        .with(
          body: {
            title: "Test api update",
            password: password,
            start: "2021-05-15T15:37:39-04:00",
            end: "2021-05-15T16:37:52-04:00",
            enabledAutoRecordMeeting: false
          }.to_json,
          headers: {
            "Authorization" => "Bearer #{access_token}",
            "Content-Type" => "application/json"
          }
        ).to_return(body: successful_response)

      meeting.update(
        meeting_id: meeting_id,
        title: "Test api update",
        password: password,
        start_date_time: "2021-05-15T15:37:39-04:00",
        end_date_time: "2021-05-15T16:37:52-04:00"
      )
    end
  end

  describe "#delete" do
    it "deletes a meeting" do
      meeting_id = "1234"
      stub_request(:delete, uri + meeting_id)
        .with(
          headers: {
            "Authorization" => "Bearer #{access_token}",
            "Content-Type" => "application/json"
          }
        ).to_return(body: successful_response)

      meeting.delete(meeting_id: meeting_id)
    end
  end

  let(:successful_response) do
    {
      "id": "123456",
      "meetingNumber": "984",
      "title": "Future Meeting by consumer",
      "password": password,
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
  end

  let(:bad_request) do
    Net::HTTPBadRequest.new("1.1", 400, "Bad Request")
  end
end
