# frozen_string_literal: true

json.student_plan do
  json.id student_plan.id
  json.plan_id student_plan.plan_id
  json.student_id student_plan.student_id
  json.started_at student_plan.started_at
  json.finished_at student_plan.finished_at
  json.status student_plan.status
  json.payment_status student_plan.payment_status
  json.partial! 'plans/plan', plan: student_plan.plan
end
