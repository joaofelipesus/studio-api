# frozen_string_literal: true

json.student do
  json.id student.id
  json.personal_id student.personal_id
  json.name student.name
  json.objective_id student.objective_id
  json.objective do
    json.id student.objective.id
    json.name student.objective.name
  end
end
