# frozen_string_literal: true

json.students do
  json.array! paginated_data[:students] do |student|
    # rubocop:disable Style/HashSyntax
    json.partial! 'students/student', student: student
    # rubocop:enable Style/HashSyntax
  end
end
json.total_pages paginated_data[:meta][:total_pages]
json.current_page paginated_data[:meta][:current_page]
