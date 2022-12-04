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
      { name: 'Alisson', objective: Objective.all.sample, personal_id: },
      { name: 'Ederson', objective: Objective.all.sample, personal: },
      { name: 'Weverton', objective: Objective.all.sample, personal: },
      { name: 'Danilo', objective: Objective.all.sample, personal: },
      { name: 'Alex Sandro', objective: Objective.all.sample, personal: },
      { name: 'Daniel Alves', objective: Objective.all.sample, personal: },
      { name: 'Alex Telles', objective: Objective.all.sample, personal: },
      { name: 'Éder Militão', objective: Objective.all.sample, personal: },
      { name: 'Marquinhos', objective: Objective.all.sample, personal: },
      { name: 'Thiago Silva', objective: Objective.all.sample, personal: },
      { name: 'Bremer', objective: Objective.all.sample, personal: },
      { name: 'Bruno Guimarães', objective: Objective.all.sample, personal: },
      { name: 'Casemiro', objective: Objective.all.sample, personal: },
      { name: 'Fabinho', objective: Objective.all.sample, personal: },
      { name: 'Fred', objective: Objective.all.sample, personal: },
      { name: 'Lucas Paquetá', objective: Objective.all.sample, personal: },
      { name: 'Everton Ribeiro', objective: Objective.all.sample, personal: },
      { name: 'Antony', objective: Objective.all.sample, personal: },
      { name: 'Gabriel Jesus', objective: Objective.all.sample, personal: },
      { name: 'Neymar', objective: Objective.all.sample, personal: },
      { name: 'Raphinha', objective: Objective.all.sample, personal: },
      { name: 'Richarlison', objective: Objective.all.sample, personal: },
      { name: 'Vinícius Jr', objective: Objective.all.sample, personal: },
      { name: 'Gabriel Martinelli', objective: Objective.all.sample, personal: },
      { name: 'Pedro', objective: Objective.all.sample, personal: },
      { name: 'Rodrygo', objective: Objective.all.sample, personal: }
    ]
  end
end
