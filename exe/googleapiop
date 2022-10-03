#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require "googleapiop"

# You can add fixtures and/or initialization code here to make experimenting
# with your gem easier. You can also use a different console, if you like.

# (If you use this, don't forget to add pry to your Gemfile!)
# require "pry"
# Pry.start
APPLICATION_NAME = "Google API Ruby Sample Program".freeze
APPLICATION_SHEET_NAME = "Google Sheets API Ruby Quickstart".freeze
APPLICATION_DOCS_NAME = "Google Docs API Ruby Quickstart".freeze
CREDENTIALS_PATH = "credentials.json".freeze
CREDENTIALS_SHEET_PATH = "credentials_sheet.json".freeze
CREDENTIALS_DOCS_PATH = "credentials_docs.json".freeze
TOKEN_PATH = "token.yaml".freeze
TOKEN_SHEET_PATH = "token_sheet.yaml".freeze
TOKEN_DOCS_PATH = "token_docs.yaml".freeze
SCOPE_SHEET = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY
SCOPE_DOCS = Google::Apis::DocsV1::AUTH_DOCUMENTS_READONLY
#SCOPE_CALENDAR = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY
SCOPE_CALENDAR = Google::Apis::CalendarV3::AUTH_CALENDAR_EVENTS
#AUTH_CALENDAR
#AUTH_CALENDAR_EVENTS
#AUTH_CALENDAR_EVENTS_READONLY
#AUTH_CALENDAR_READONLY
#AUTH_CALENDAR_SETTINGS_READONLY



SCOPES = [SCOPE_SHEET, SCOPE_DOCS, SCOPE_CALENDAR]

def process_sheet
#=begin
  list_1 = @gao.sheet_run
  list_2 = @gao.gh_run

  p list_1 - list_2

  p list_2 - list_1
#=end
end

def process_docs
  #process_sheet
  #https://docs.google.com/document/d/1ZPQuSkUsr-r1w6qaz0uoyGn-yRBBBdB-2odeqWAamZA/edit
  document_id = "1ZPQuSkUsr-r1w6qaz0uoyGn-yRBBBdB-2odeqWAamZA"
  @gao.doc_run(document_id)

  #https://drive.google.com/drive/folders/1EFrWRBgrAIm-mdtIEFKlIp4LQ6VMUOIG
  #https://docs.google.com/document/d/1z91l6eR5ujU5qL0xbAO-cYKU8NmkKIword1ckpKHPOw/edit
  document_id = "1z91l6eR5ujU5qL0xbAO-cYKU8NmkKIword1ckpKHPOw"
  @gao.doc_run(document_id)

=begin
https://docs.google.com/document/d/1Rf1b4P-WoGXNVHecRd-55IkELkLYIhB4ray5B9a7qnw/edit
document_id = "1z91l6eR5ujU5qL0xbAO-cYKU8NmkKIword1ckpKHPOw"
gao.doc_run(document_id)
=end
end

@gao = Googleapiop::Googleapiop.new(APPLICATION_NAME, CREDENTIALS_PATH,
  TOKEN_PATH, SCOPES)

#process_sheet
#process_docs

def process_calendar
  #calendar_id = "primary"
  # toppers
  calendar_id = "bXJibTJ1MTE4NnZ1MG92Z3BhNWM2Y3I2OWdAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ"
  # https://calendar.google.com/calendar/u/0/r/settings/calendar/dHJydmhya285b2h0MmhpYWh0aWRkbmlvODBAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ?tab=mc&pli=1
  # birthdays
  calendar_id = "dHJydmhya285b2h0MmhpYWh0aWRkbmlvODBAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ"
  @gao.cal_run(calendar_id)
end

#process_calendar

@gao.create_recurring_event