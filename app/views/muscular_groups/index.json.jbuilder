# frozen_string_literal: true

json.muscular_groups do
  json.array! muscular_groups do |muscular_group|
    json.partial! 'muscular_groups/muscular_group', muscular_group: muscular_group
  end
end
