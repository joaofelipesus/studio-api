# frozen_string_literal: true

json.students do
  json.array! students do |student|
    json.partial! 'students/student', student: student
  end
end
