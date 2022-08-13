# frozen_string_literal: true

module ExercisesGroups
  class CreateService
    def initialize(params)
      @params = params
      @exercises_group = nil
    end

    def self.call(params)
      new(params).call
    end

    def call
      ActiveRecord::Base.transaction do
        @exercises_group = ExercisesGroup.create!(exercises_group_params)
        create_exercises_schedules
        @exercises_group
      rescue ActiveRecord::RecordInvalid
        @exercises_group
      end
    end

    private

    attr_accessor :params

    def exercises_group_params
      { workout_plan_id:, execution_sequence: }
    end

    def execution_sequence
      ExercisesGroup.where(workout_plan_id:).size + 1
    end

    def workout_plan_id
      params[:workout_plan_id]
    end

    def exercise_schedules_params
      params[:exercise_schedules]
    end

    def create_exercises_schedules
      exercise_schedules_params.each do |exercise_schedule_params|
        ExerciseSchedule.create!(
          exercise_schedule_params.merge(
            exercises_group_id: @exercises_group.id
          )
        )
      end
    end
  end
end
