# frozen_string_literal: true

namespace :default_registers do
  desc 'Create default exercises'
  task :exercises, [:personal_id] => :environment do |task, args|
    pectoral(args)
    dorsal(args)
    deltoids(args)
    trapeze(args)
    triceps(args)
    biceps(args)
    forearm(args)
    thighs(args)
    glutes(args)
    calf(args)
    abdomen(args)
  end

  def pectoral(args)
    muscular_group = MuscularGroup.find_by(name: 'Peitoral')
    Exercise.create(
      [
        { name: 'Supino Reto Barra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Supino Reto Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Supino Reto Smith', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Supino Inclinado Barra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Supino Inclinado Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Supino Inclinado Smith', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Supino Declinado Barra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Supino Declinado Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Supino Declinado Smith', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Crucifixo Reto Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Crucifixo Inclinado Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Crucifixo Declinado Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Cross-Over Polia Alta', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Cross-Over Polia Média', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Cross-Over Polia Baixa', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Crucifixo Na Máquina', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Flexão De Braço', muscular_group: muscular_group, personal_id: args[:personal_id] }
      ]
    )
  end

  def dorsal(args)
    muscular_group = MuscularGroup.find_by(name: 'Dorsais')
    Exercise.create(
      [
        { name: 'Barra Fixa Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Barra Fixa Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Barra Fixa Com Triângulo', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Levantamento Terra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Puxada Vertical Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Puxada Vertical Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Puxada Vertical Com Triângulo', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Curvada Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Curvada Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Curvada Cavalinho', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Curvada Halteres Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Curvada Halteres Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Curvada Halteres Peg Neutra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Máquina Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Máquina Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Máquina Peg Neutra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Cross Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Cross Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Cross Peg Neutra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Unilateral Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Unilateral Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Unilateral Peg Neutra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Pull-Down Barra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Pull-Down Cross Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Pull-Down Cross Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Pull-Down Cross Corda', muscular_group: muscular_group, personal_id: args[:personal_id] }
      ]
    )
  end

  def deltoids(args)
    muscular_group = MuscularGroup.find_by(name: 'Deltóides')
    Exercise.create(
      [
        { name: 'Elevação Lateral Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Lateral Sentado Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Lateral Cross Posterior', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Lateral Cross Anterior', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Lateral Unilateral Banco Inclinado', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Frontal Barra Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Frontal Barra Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Frontal Halteres Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Frontal Halteres Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Frontal Halteres Peg Neutra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Frontal Cross Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Frontal Cross Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Frontal Cross Corda', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Frontal Anilha', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Frontal Cruzada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Crucifixo Inverso Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Crucifixo Inverso Cross', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Desenvolvimento Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Desenvolvimento Anterior', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Desenvolvimento Posterior', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Desenvolvimento Militar', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Desenvolvimento Smith', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Desenvolvimento Máquina', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Manguito Rotador Externo Barra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Manguito Rotador Externo Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] }
      ]
    )
  end

  def trapeze(args)
    muscular_group = MuscularGroup.find_by(name: 'Trapézio')
    Exercise.create(
      [
        { name: 'Encolhimento Barra Anterior', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Encolhimento Barra Posterior', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Encolhimento Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Encolhimento Smith Anterior', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Encolhimento Smith Posterior', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Alta Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Alta Barra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Alta Cross', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Remada Alta Smith', muscular_group: muscular_group, personal_id: args[:personal_id] }
      ]
    )
  end

  def triceps(args)
    muscular_group = MuscularGroup.find_by(name: 'Tríceps')
    Exercise.create(
      [
        { name: 'Paralelas', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Mergulho', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Supino Fechado', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Testa Barra Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Testa Barra Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Testa Halteres Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Testa Halteres Peg Neutra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Testa Halteres Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Tríceps Pulley Corda', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Tríceps Pulley Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Tríceps Pulley Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Tríceps Pulley Unilateral Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Tríceps Pulley Unilateral Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Francesa Anilha', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Francesa Barra Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Francesa Barra Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Francesa Halteres Peg Neutra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Francesa Halteres Peg Supinada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Francesa Halteres Peg Pronada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Francesa Cross Corda', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Tríceps Coice Bilateral Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Tríceps Coice Unilateral Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Tríceps Coice Unilateral Cross', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Flexão De Braço Fechada', muscular_group: muscular_group, personal_id: args[:personal_id] }
      ]
    )
  end

  def biceps(args)
    muscular_group = MuscularGroup.find_by(name: 'Bíceps')
    Exercise.create(
      [
        { name: 'Rosca Direta Barra Reta ou Barra W', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Direta Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Direta Cross', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Martelo Barra H', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Martelo Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Martelo Corda Cross', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Alternada Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Alternada Cross-Over', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Scott Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Scott Barra ou Barra W', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Scott Máquina', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Concentrada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Concentrada Martelo', muscular_group: muscular_group, personal_id: args[:personal_id] }
      ]
    )
  end

  def forearm(args)
    muscular_group = MuscularGroup.find_by(name: 'Antebraço')
    Exercise.create(
      [
        { name: 'Flexão de Punho Barra Sentado', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Extensão de Punho Barra Sentado', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Extensão de Punho Barra Em Pé', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Extensão de Punho Cross', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Flexão de Punho Cross', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rotacional de Punho', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Inversa Barra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Inversa Cross', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Rosca Inversa Alternada', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Flexão de Punho Barra Em Pé', muscular_group: muscular_group, personal_id: args[:personal_id] }
      ]
    )
  end

  def thighs(args)
    muscular_group = MuscularGroup.find_by(name: 'Coxas')
    Exercise.create(
      [
        { name: 'Agachamento Livre', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Agachamento Livre Frontal', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Agachamento Hack', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Agachamento Smith', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Agachamento Smith Frontal', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Agachamento Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Agachamento Adutores', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Passada Barra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Passada Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Afundos Barra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Afundos Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Afundos Smith', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Cadeira Extensora', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Mesa Flexora', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Cadeira Flexora', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Flexor Vertical', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Leg Press', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Leg Press Adutores', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Stiff Barra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Stiff Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Stiff Smith', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Agachamento Bulgaro Halteres', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Agachamento Bulgaro Barra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Cadeira Adutora', muscular_group: muscular_group, personal_id: args[:personal_id] }
      ]
    )
  end

  def glutes(args)
    muscular_group = MuscularGroup.find_by(name: 'Glúteos')
    Exercise.create(
      [
        { name: '4 Apoios Joelho Estendido', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: '4 Apoios Joelho Flexionado', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Glúteos Graviton', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Glúteos Máquina', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Glúteos Smith', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Glúteos Cross', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Pélvica Barra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Pélvica Halter', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Pélvica Anilha', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Elevação Pélvica Smith', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Cadeira Abdutora', muscular_group: muscular_group, personal_id: args[:personal_id] }
      ]
    )
  end

  def calf(args)
    muscular_group = MuscularGroup.find_by(name: 'Panturrilha')
    Exercise.create(
      [
        { name: 'Gêmeos Em Pé Máquina', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Gêmeos Em Pé Hack', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Gêmeos Em Pé Smith', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Gêmeos Em Pé Livre', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Gêmeos Sentado Máquina', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Gêmeos Sentado Smith', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Gêmeos Sentado Livre', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Gêmeos Leg Press', muscular_group: muscular_group, personal_id: args[:personal_id] }
      ]
    )
  end

  def abdomen(args)
    muscular_group = MuscularGroup.find_by(name: 'Abdomên')
    Exercise.create(
      [
        { name: 'Supra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Infra', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Oblíquos', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Prancha', muscular_group: muscular_group, personal_id: args[:personal_id] },
        { name: 'Extensão Lombar', muscular_group: muscular_group, personal_id: args[:personal_id] }
      ]
    )
  end
end
