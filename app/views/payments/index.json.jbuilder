# frozen_string_literal: true

json.payments do
  json.array! paginated_data[:payments] do |payment|
    json.partial! 'payments/payment', payment:
  end
end
json.total_pages paginated_data[:meta][:total_pages]
json.current_page paginated_data[:meta][:current_page]
