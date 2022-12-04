# frozen_string_literal: true

namespace :seed do
  desc 'Create default workout plans'
  task :workout_plans, [:personal_id] => :environment do |task, args|
    puts 'Workout plans [start]'
    return unless Rails.env.development?

    workout_plan = WorkoutPlan.find_by(personal_id: args[:personal_id], name: 'Força')
    if workout_plan.nil?
      puts 'Workout plans [create]'
      WorkoutPlan.create!(workout_plans_seeds(args[:personal_id]))
      add_exercises_groups(args[:personal_id])
    else
      puts 'Workout plans [skip]'
    end

    puts '-------------------'
  end

  def workout_plans_seeds(personal_id)
    [
      { name: 'Força', personal_id: },
      { name: 'Emagrecimento', personal_id: },
      { name: 'Ganho de definição', personal_id: },
      { name: 'Fortaleciemento perna', personal_id: },
      { name: 'Ganho de resistência', personal_id: }
    ]
  end

  def add_exercises_groups(personal_id)
    WorkoutPlan.all.each do |workout_plan|
      first_exercises_group = ExercisesGroup.create!(workout_plan:, execution_sequence: 1)
      second_exercises_group = ExercisesGroup.create!(workout_plan:, execution_sequence: 2)

      6.times do |index|
        ExerciseSchedule.create!(
          exercise: Exercise.where(personal_id:).sample,
          exercises_group: first_exercises_group,
          exercise_sequence: index + 1,
          rest: ExerciseSchedule.rests.keys.sample,
          repetitions: ExerciseSchedule.repetitions.keys.sample
        )
      end

      6.times do |index|
        ExerciseSchedule.create!(
          exercise: Exercise.where(personal_id:).sample,
          exercises_group: second_exercises_group,
          exercise_sequence: index + 1,
          rest: ExerciseSchedule.rests.keys.sample,
          repetitions: ExerciseSchedule.repetitions.keys.sample
        )
      end
    end
  end
end
