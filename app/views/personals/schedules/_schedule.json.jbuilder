# frozen_string_literal: true

json.schedule do
  json.id schedule.id
  json.workout_plan_id schedule.workout_plan_id
  json.student_id schedule.student_id
  json.start_at schedule.start_at
  json.date schedule.date.to_s
  json.status schedule.status
  json.personal_id schedule.personal_id
  json.partial! 'personals/workout_plans/workout_plan', workout_plan: schedule.workout_plan
  json.partial! 'personals/students/student', student: schedule.student
end
