# frozen_string_literal: true

json.payment do
  json.id payment.id
  json.amount payment.amount
  json.payment_method payment.payment_method
  json.student_plan_id payment.student_plan_id
  json.date payment.date.to_s
end
