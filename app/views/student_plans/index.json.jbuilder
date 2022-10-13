# frozen_string_literal: true

json.student_plans do
  json.array! paginated_data[:student_plans] do |student_plan|
    # rubocop:disable Style/HashSyntax
    json.partial! 'student_plans/student_plan', student_plan: student_plan
    # rubocop:enable Style/HashSyntax
  end
end
json.current_page paginated_data[:meta][:current_page]
json.total_pages paginated_data[:meta][:total_pages]
