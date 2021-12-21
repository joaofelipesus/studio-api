# frozen_string_literal: true

json.student do
  json.id student.id
  json.personal_id student.personal_id
  json.user do
    json.name student.user.name
    json.email student.user.email
  end
end
