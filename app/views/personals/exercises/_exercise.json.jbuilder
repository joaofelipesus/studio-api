# frozen_string_literal: true

json.exercise do
  json.id exercise.id
  json.name exercise.name
  json.muscular_group_id exercise.muscular_group_id
  json.muscular_group do
    json.name exercise.muscular_group.name
  end
end
