# frozen_string_literal: true

json.plan do
  json.id plan.id
  json.name plan.name
  json.monthly_price plan.monthly_price
  json.duration_in_months plan.duration_in_months
end
