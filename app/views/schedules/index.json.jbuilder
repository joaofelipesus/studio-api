# frozen_string_literal: true

json.schedules do
  json.array! schedules do |schedule|
    # rubocop:disable Style/HashSyntax
    json.partial! 'schedules/schedule', schedule: schedule
    # rubocop:enable Style/HashSyntax
  end
end
json.current_page current_page
json.total_pages total_pages
