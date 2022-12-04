# frozen_string_literal: true

namespace :seed do
  desc 'Create default students'
  task :students, [:personal_id] => :environment do |task, args|
    puts 'Student [start]'
    return unless Rails.env.development?

    student = Student.find_by(personal_id: args[:personal_id], name: 'Alisson')
    if student.nil?
      puts 'Student [create]'
      Student.create!(student_seeds(args[:personal_id]))
    else
      puts 'Student [skip]'
    end

    puts '-------------------'
  end

  def student_seeds(personal_id)
    [
      { name: 'Alisson', objective: Objective.all.sample, personal_id:, created_at: 2.months.ago },
      { name: 'Ederson', objective: Objective.all.sample, personal:, created_at: 1.months.ago },
      { name: 'Weverton', objective: Objective.all.sample, personal: , created_at: 2.months.ago },
      { name: 'Danilo', objective: Objective.all.sample, personal: , created_at: 4.months.ago },
      { name: 'Alex Sandro', objective: Objective.all.sample, personal: , created_at: 5.months.ago },
      { name: 'Daniel Alves', objective: Objective.all.sample, personal: , created_at: 1.months.ago },
      { name: 'Alex Telles', objective: Objective.all.sample, personal: , created_at: 2.months.ago },
      { name: 'Éder Militão', objective: Objective.all.sample, personal: , created_at: 3.months.ago },
      { name: 'Marquinhos', objective: Objective.all.sample, personal: , created_at: 1.months.ago },
      { name: 'Thiago Silva', objective: Objective.all.sample, personal: , created_at: 1.months.ago },
      { name: 'Bremer', objective: Objective.all.sample, personal: , created_at: 5.months.ago },
      { name: 'Bruno Guimarães', objective: Objective.all.sample, personal: , created_at: 4.months.ago },
      { name: 'Casemiro', objective: Objective.all.sample, personal: , created_at: 1.months.ago },
      { name: 'Fabinho', objective: Objective.all.sample, personal: , created_at: 1.months.ago },
      { name: 'Fred', objective: Objective.all.sample, personal: , created_at: 2.months.ago },
      { name: 'Lucas Paquetá', objective: Objective.all.sample, personal: , created_at: 5.months.ago },
      { name: 'Everton Ribeiro', objective: Objective.all.sample, personal: , created_at: 1.months.ago },
      { name: 'Antony', objective: Objective.all.sample, personal: , created_at: 2.months.ago },
      { name: 'Gabriel Jesus', objective: Objective.all.sample, personal: , created_at: 1.months.ago },
      { name: 'Neymar', objective: Objective.all.sample, personal: , created_at: 4.months.ago },
      { name: 'Raphinha', objective: Objective.all.sample, personal: , created_at: 3.months.ago },
      { name: 'Richarlison', objective: Objective.all.sample, personal: , created_at: 2.months.ago },
      { name: 'Vinícius Jr', objective: Objective.all.sample, personal: , created_at: 2.months.ago },
      { name: 'Gabriel Martinelli', objective: Objective.all.sample, personal: , created_at: 2.months.ago },
      { name: 'Pedro', objective: Objective.all.sample, personal: , created_at: 1.months.ago },
      { name: 'Rodrygo', objective: Objective.all.sample, personal: , created_at: 1.months.ago }
    ]
  end
end
