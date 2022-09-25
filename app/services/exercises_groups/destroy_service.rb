# frozen_string_literal: true

module ExercisesGroups
  class DestroyService
    def initialize(id:)
      @id = id
    end

    def self.call(id:)
      new(id:).call
    end

    def call
      ActiveRecord::Base.transaction do
        exercises_group.destroy
        remaining_exercises_groups.each_with_index do |exercises_group, index|
          exercises_group.update(execution_sequence: index + 1)
        end
      end
    end

    private

    attr_reader :id

    def exercises_group
      @exercises_group ||= ::ExercisesGroup.find(id)
    end

    def remaining_exercises_groups
      exercises_group.workout_plan.reload.exercises_groups
    end
  end
end
