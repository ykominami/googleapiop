# frozen_string_literal: true

require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'open3'

require 'google/apis/docs_v1'
require 'google/apis/calendar_v3'

module Googleapiop
  # Google API操作クラス
  class Googleapiop
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
    # The file token.yaml stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.

    def initialize(application_name, credentials_path, token_path, scopes)
      @application_name = application_name
      @credentials_path = credentials_path
      @token_path = token_path
      @scopes = scopes

      @service_sheet = Google::Apis::SheetsV4::SheetsService.new
      @service_sheet.client_options.application_name = @application_name
      @service_sheet.authorization = authorize

      @service_docs = Google::Apis::DocsV1::DocsService.new
      @service_docs.client_options.application_name = @application_name
      @service_docs.authorization = authorize

      @service_calendar = Google::Apis::CalendarV3::CalendarService.new
      @service_calendar.client_options.application_name = @application_name
      @service_calendar.authorization = authorize
    end

    def authorize
      client_id = Google::Auth::ClientId.from_file @credentials_path
      token_store = Google::Auth::Stores::FileTokenStore.new file: @token_path
      authorizer = Google::Auth::UserAuthorizer.new client_id, @scopes, token_store
      user_id = 'default'
      credentials = authorizer.get_credentials user_id
      if credentials.nil?
        url = authorizer.get_authorization_url base_url: OOB_URI
        puts 'Open the following URL in the browser and enter the ' \
             "resulting code after authorization:\n" + url
        code = gets
        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI
        )
      end
      credentials
    end

    def sheet_run(_spredsheet_id = nil)
      spreadsheet_id ||= '1CeskOJWkqKEPJhIBDFOKS8i7uw7tjq3B-G2u-eyC0ac'
      range = 'A1:F'
      response = @service_sheet.get_spreadsheet_values spreadsheet_id, range
      # puts "category, Repo:"
      list = []
      # puts "No data found." if response.values.empty?
      response.each_value do |row|
        # Print columns A and E, which correspond to indices 0 and 4.
        # puts "#{row[0]}, #{row[2]}, #{row[3]}, #{row[4]}, #{row[5]}"
        # puts row[0..5].join(",")
        list << row[2]
      end
      list
    end

    def doc_run(document_id = nil)
      document_id ||= '195j9eDD3ccgjQRttHhJPymLJUCOUjs-jmwTrekvdjFE'
      document = @service_docs.get_document document_id
      puts "The title of the document is: #{document.title}."
    end

    def gh_run
      _stdin, stdout, _stderr = *Open3.popen3('gh repo list --private --limit 300')
      list = []
      stdout.each do |line|
        ary = line.split(/\t+/)
        list << ary.shift
      end
      list
    end

    def cal_run(calendar_id = nil)
      calendar_id ||= 'primary'
      response = @service_calendar.list_events(calendar_id,
                                               max_results: 10,
                                               single_events: true,
                                               order_by: 'startTime',
                                               time_min: DateTime.now.rfc3339)
      puts 'Upcoming events:'
      puts 'No upcoming events found' if response.items.empty?
      response.items.each do |event|
        start = event.start.date || event.start.date_time
        puts "- #{event.summary} (#{start})"
      end
    end

    def create_recurring_event
      event = Google::Apis::CalendarV3::Event.new(
        summary: 'Appointment',
        location: 'Somewhere',
        start: {
          date_time: '2022-09-03T10:00:00.000-07:00',
          time_zone: 'Asia/Tokyo'
        },
        end: {
          date_time: '2022-09-03T10:25:00.000-07:00',
          time_zone: 'Asia/Tokyo'
        },
        recurrence: ['RRULE:FREQ=WEEKLY;UNTIL=20220901T170000Z'],
        attendees: [
          {
            email: 'ykominami@gmail.com'
          }
        ]
      )
      response = @service_calendar.insert_event('primary', event)
      print response.id
    end
  end
end
