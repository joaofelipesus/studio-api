# frozen_string_literal: true

json.students do
  json.array! students do |student|
    # rubocop:disable Style/HashSyntax
    json.partial! 'students/student', student: student
    # rubocop:enable Style/HashSyntax
  end
end
if paginate
  json.total_pages total_pages
  json.current_page current_page
end
