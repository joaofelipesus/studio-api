# frozen_string_literal: true

json.schedules do
  json.array! paginated_data[:schedules] do |schedule|
    # rubocop:disable Style/HashSyntax
    json.partial! 'schedules/schedule', schedule: schedule
    # rubocop:enable Style/HashSyntax
  end
end
json.current_page paginated_data[:meta][:current_page]
json.total_pages paginated_data[:meta][:total_pages]
