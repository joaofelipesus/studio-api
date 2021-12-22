# frozen_string_literal: true

json.schedule do
  json.id schedule.id
  json.workout_plan_id schedule.workout_plan_id
  json.student_id schedule.student_id
  json.start_at schedule.start_at.to_s
  json.status schedule.status
  json.personal_id schedule.personal_id
  json.partial! 'workout_plans/workout_plan', workout_plan: schedule.workout_plan
  json.partial! 'students/student', student: schedule.student
end
