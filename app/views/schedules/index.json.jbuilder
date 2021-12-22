# frozen_string_literal: true

json.schedules do
  json.array! schedules do |schedule|
    json.partial! 'schedules/schedule', schedule: schedule
  end
end
json.current_page current_page
json.total_pages total_pages
