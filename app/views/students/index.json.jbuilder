# frozen_string_literal: true

json.students do
  json.array! students do |student|
    json.partial! 'students/student', student: student
  end
end
json.total_pages total_pages
json.current_page current_page
