# frozen_string_literal: true

json.plans do
  json.array! plans do |plan|
    json.partial! 'plans/plan', plan:
  end
end
