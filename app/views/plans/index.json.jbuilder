# frozen_string_literal: true

json.plans do
  json.array! paginated_data[:plans] do |plan|
    json.partial! 'plans/plan', plan:
  end
end
json.total_pages paginated_data[:meta][:total_pages]
json.current_page paginated_data[:meta][:current_page]
