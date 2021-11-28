# frozen_string_literal: true

namespace :default_registers do
  desc 'Create default exercises'
  task exercises: :environment do
    pectoral
    dorsal
    deltoids
    trapeze
    triceps
    biceps
    forearm
    thighs
    glutes
    calf
    abdomen
  end

  def pectoral
    muscular_group = MuscularGroup.find_by(name: 'Peitoral')
    Exercise.create(
      [
        { name: 'Supino Reto Barra', muscular_group: muscular_group },
        { name: 'Supino Reto Halteres', muscular_group: muscular_group },
        { name: 'Supino Reto Smith', muscular_group: muscular_group },
        { name: 'Supino Inclinado Barra', muscular_group: muscular_group },
        { name: 'Supino Inclinado Halteres', muscular_group: muscular_group },
        { name: 'Supino Inclinado Smith', muscular_group: muscular_group },
        { name: 'Supino Declinado Barra', muscular_group: muscular_group },
        { name: 'Supino Declinado Halteres', muscular_group: muscular_group },
        { name: 'Supino Declinado Smith', muscular_group: muscular_group },
        { name: 'Crucifixo Reto Halteres', muscular_group: muscular_group },
        { name: 'Crucifixo Inclinado Halteres', muscular_group: muscular_group },
        { name: 'Crucifixo Declinado Halteres', muscular_group: muscular_group },
        { name: 'Cross-Over Polia Alta', muscular_group: muscular_group },
        { name: 'Cross-Over Polia Média', muscular_group: muscular_group },
        { name: 'Cross-Over Polia Baixa', muscular_group: muscular_group },
        { name: 'Crucifixo Na Máquina', muscular_group: muscular_group },
        { name: 'Flexão De Braço', muscular_group: muscular_group }
      ]
    )
  end

  def dorsal
    muscular_group = MuscularGroup.find_by(name: 'Dorsais')
    Exercise.create(
      [
        { name: 'Barra Fixa Peg Pronada', muscular_group: muscular_group },
        { name: 'Barra Fixa Peg Supinada', muscular_group: muscular_group },
        { name: 'Barra Fixa Com Triângulo', muscular_group: muscular_group },
        { name: 'Levantamento Terra', muscular_group: muscular_group },
        { name: 'Puxada Vertical Peg Pronada', muscular_group: muscular_group },
        { name: 'Puxada Vertical Peg Supinada', muscular_group: muscular_group },
        { name: 'Puxada Vertical Com Triângulo', muscular_group: muscular_group },
        { name: 'Remada Curvada Peg Pronada', muscular_group: muscular_group },
        { name: 'Remada Curvada Peg Supinada', muscular_group: muscular_group },
        { name: 'Remada Curvada Cavalinho', muscular_group: muscular_group },
        { name: 'Remada Curvada Halteres Peg Pronada', muscular_group: muscular_group },
        { name: 'Remada Curvada Halteres Peg Supinada', muscular_group: muscular_group },
        { name: 'Remada Curvada Halteres Peg Neutra', muscular_group: muscular_group },
        { name: 'Remada Máquina Peg Pronada', muscular_group: muscular_group },
        { name: 'Remada Máquina Peg Supinada', muscular_group: muscular_group },
        { name: 'Remada Máquina Peg Neutra', muscular_group: muscular_group },
        { name: 'Remada Cross Peg Pronada', muscular_group: muscular_group },
        { name: 'Remada Cross Peg Supinada', muscular_group: muscular_group },
        { name: 'Remada Cross Peg Neutra', muscular_group: muscular_group },
        { name: 'Remada Unilateral Peg Pronada', muscular_group: muscular_group },
        { name: 'Remada Unilateral Peg Supinada', muscular_group: muscular_group },
        { name: 'Remada Unilateral Peg Neutra', muscular_group: muscular_group },
        { name: 'Pull-Down Barra', muscular_group: muscular_group },
        { name: 'Pull-Down Cross Peg Pronada', muscular_group: muscular_group },
        { name: 'Pull-Down Cross Peg Supinada', muscular_group: muscular_group },
        { name: 'Pull-Down Cross Corda', muscular_group: muscular_group }
      ]
    )
  end

  def deltoids
    muscular_group = MuscularGroup.find_by(name: 'Deltóides')
    Exercise.create(
      [
        { name: 'Elevação Lateral Halteres', muscular_group: muscular_group },
        { name: 'Elevação Lateral Sentado Halteres', muscular_group: muscular_group },
        { name: 'Elevação Lateral Cross Posterior', muscular_group: muscular_group },
        { name: 'Elevação Lateral Cross Anterior', muscular_group: muscular_group },
        { name: 'Elevação Lateral Unilateral Banco Inclinado', muscular_group: muscular_group },
        { name: 'Elevação Frontal Barra Peg Pronada', muscular_group: muscular_group },
        { name: 'Elevação Frontal Barra Peg Supinada', muscular_group: muscular_group },
        { name: 'Elevação Frontal Halteres Peg Pronada', muscular_group: muscular_group },
        { name: 'Elevação Frontal Halteres Peg Supinada', muscular_group: muscular_group },
        { name: 'Elevação Frontal Halteres Peg Neutra', muscular_group: muscular_group },
        { name: 'Elevação Frontal Cross Peg Pronada', muscular_group: muscular_group },
        { name: 'Elevação Frontal Cross Peg Supinada', muscular_group: muscular_group },
        { name: 'Elevação Frontal Cross Corda', muscular_group: muscular_group },
        { name: 'Elevação Frontal Anilha', muscular_group: muscular_group },
        { name: 'Elevação Frontal Cruzada', muscular_group: muscular_group },
        { name: 'Crucifixo Inverso Halteres', muscular_group: muscular_group },
        { name: 'Crucifixo Inverso Cross', muscular_group: muscular_group },
        { name: 'Desenvolvimento Halteres', muscular_group: muscular_group },
        { name: 'Desenvolvimento Anterior', muscular_group: muscular_group },
        { name: 'Desenvolvimento Posterior', muscular_group: muscular_group },
        { name: 'Desenvolvimento Militar', muscular_group: muscular_group },
        { name: 'Desenvolvimento Smith', muscular_group: muscular_group },
        { name: 'Desenvolvimento Máquina', muscular_group: muscular_group },
        { name: 'Manguito Rotador Externo Barra', muscular_group: muscular_group },
        { name: 'Manguito Rotador Externo Halteres', muscular_group: muscular_group }
      ]
    )
  end

  def trapeze
    muscular_group = MuscularGroup.find_by(name: 'Trapézio')
    Exercise.create(
      [
        { name: 'Encolhimento Barra Anterior', muscular_group: muscular_group },
        { name: 'Encolhimento Barra Posterior', muscular_group: muscular_group },
        { name: 'Encolhimento Halteres', muscular_group: muscular_group },
        { name: 'Encolhimento Smith Anterior', muscular_group: muscular_group },
        { name: 'Encolhimento Smith Posterior', muscular_group: muscular_group },
        { name: 'Remada Alta Halteres', muscular_group: muscular_group },
        { name: 'Remada Alta Barra', muscular_group: muscular_group },
        { name: 'Remada Alta Cross', muscular_group: muscular_group },
        { name: 'Remada Alta Smith', muscular_group: muscular_group }
      ]
    )
  end

  def triceps
    muscular_group = MuscularGroup.find_by(name: 'Tríceps')
    Exercise.create(
      [
        { name: 'Paralelas', muscular_group: muscular_group },
        { name: 'Mergulho', muscular_group: muscular_group },
        { name: 'Supino Fechado', muscular_group: muscular_group },
        { name: 'Rosca Testa Barra Peg Pronada', muscular_group: muscular_group },
        { name: 'Rosca Testa Barra Peg Supinada', muscular_group: muscular_group },
        { name: 'Rosca Testa Halteres Peg Supinada', muscular_group: muscular_group },
        { name: 'Rosca Testa Halteres Peg Neutra', muscular_group: muscular_group },
        { name: 'Rosca Testa Halteres Peg Pronada', muscular_group: muscular_group },
        { name: 'Tríceps Pulley Corda', muscular_group: muscular_group },
        { name: 'Tríceps Pulley Peg Pronada', muscular_group: muscular_group },
        { name: 'Tríceps Pulley Peg Supinada', muscular_group: muscular_group },
        { name: 'Tríceps Pulley Unilateral Peg Pronada', muscular_group: muscular_group },
        { name: 'Tríceps Pulley Unilateral Peg Supinada', muscular_group: muscular_group },
        { name: 'Rosca Francesa Anilha', muscular_group: muscular_group },
        { name: 'Rosca Francesa Barra Peg Pronada', muscular_group: muscular_group },
        { name: 'Rosca Francesa Barra Peg Supinada', muscular_group: muscular_group },
        { name: 'Rosca Francesa Halteres Peg Neutra', muscular_group: muscular_group },
        { name: 'Rosca Francesa Halteres Peg Supinada', muscular_group: muscular_group },
        { name: 'Rosca Francesa Halteres Peg Pronada', muscular_group: muscular_group },
        { name: 'Rosca Francesa Cross Corda', muscular_group: muscular_group },
        { name: 'Tríceps Coice Bilateral Halteres', muscular_group: muscular_group },
        { name: 'Tríceps Coice Unilateral Halteres', muscular_group: muscular_group },
        { name: 'Tríceps Coice Unilateral Cross', muscular_group: muscular_group },
        { name: 'Flexão De Braço Fechada', muscular_group: muscular_group }
      ]
    )
  end

  def biceps
    muscular_group = MuscularGroup.find_by(name: 'Bíceps')
    Exercise.create(
      [
        { name: 'Rosca Direta Barra Reta ou Barra W', muscular_group: muscular_group },
        { name: 'Rosca Direta Halteres', muscular_group: muscular_group },
        { name: 'Rosca Direta Cross', muscular_group: muscular_group },
        { name: 'Rosca Martelo Barra H', muscular_group: muscular_group },
        { name: 'Rosca Martelo Halteres', muscular_group: muscular_group },
        { name: 'Rosca Martelo Corda Cross', muscular_group: muscular_group },
        { name: 'Rosca Alternada Halteres', muscular_group: muscular_group },
        { name: 'Rosca Alternada Cross-Over', muscular_group: muscular_group },
        { name: 'Rosca Scott Halteres', muscular_group: muscular_group },
        { name: 'Rosca Scott Barra ou Barra W', muscular_group: muscular_group },
        { name: 'Rosca Scott Máquina', muscular_group: muscular_group },
        { name: 'Rosca Concentrada', muscular_group: muscular_group },
        { name: 'Rosca Concentrada Martelo', muscular_group: muscular_group }
      ]
    )
  end

  def forearm
    muscular_group = MuscularGroup.find_by(name: 'Antebraço')
    Exercise.create(
      [
        { name: 'Flexão de Punho Barra Sentado', muscular_group: muscular_group },
        { name: 'Extensão de Punho Barra Sentado', muscular_group: muscular_group },
        { name: 'Extensão de Punho Barra Em Pé', muscular_group: muscular_group },
        { name: 'Extensão de Punho Cross', muscular_group: muscular_group },
        { name: 'Flexão de Punho Cross', muscular_group: muscular_group },
        { name: 'Rotacional de Punho', muscular_group: muscular_group },
        { name: 'Rosca Inversa Barra', muscular_group: muscular_group },
        { name: 'Rosca Inversa Cross', muscular_group: muscular_group },
        { name: 'Rosca Inversa Alternada', muscular_group: muscular_group },
        { name: 'Flexão de Punho Barra Em Pé', muscular_group: muscular_group }
      ]
    )
  end

  def thighs
    muscular_group = MuscularGroup.find_by(name: 'Coxas')
    Exercise.create(
      [
        { name: 'Agachamento Livre', muscular_group: muscular_group },
        { name: 'Agachamento Livre Frontal', muscular_group: muscular_group },
        { name: 'Agachamento Hack', muscular_group: muscular_group },
        { name: 'Agachamento Smith', muscular_group: muscular_group },
        { name: 'Agachamento Smith Frontal', muscular_group: muscular_group },
        { name: 'Agachamento Halteres', muscular_group: muscular_group },
        { name: 'Agachamento Adutores', muscular_group: muscular_group },
        { name: 'Passada Barra', muscular_group: muscular_group },
        { name: 'Passada Halteres', muscular_group: muscular_group },
        { name: 'Afundos Barra', muscular_group: muscular_group },
        { name: 'Afundos Halteres', muscular_group: muscular_group },
        { name: 'Afundos Smith', muscular_group: muscular_group },
        { name: 'Cadeira Extensora', muscular_group: muscular_group },
        { name: 'Mesa Flexora', muscular_group: muscular_group },
        { name: 'Cadeira Flexora', muscular_group: muscular_group },
        { name: 'Flexor Vertical', muscular_group: muscular_group },
        { name: 'Leg Press', muscular_group: muscular_group },
        { name: 'Leg Press Adutores', muscular_group: muscular_group },
        { name: 'Stiff Barra', muscular_group: muscular_group },
        { name: 'Stiff Halteres', muscular_group: muscular_group },
        { name: 'Stiff Smith', muscular_group: muscular_group },
        { name: 'Agachamento Bulgaro Halteres', muscular_group: muscular_group },
        { name: 'Agachamento Bulgaro Barra', muscular_group: muscular_group },
        { name: 'Cadeira Adutora', muscular_group: muscular_group }
      ]
    )
  end

  def glutes
    muscular_group = MuscularGroup.find_by(name: 'Glúteos')
    Exercise.create(
      [
        { name: '4 Apoios Joelho Estendido', muscular_group: muscular_group },
        { name: '4 Apoios Joelho Flexionado', muscular_group: muscular_group },
        { name: 'Glúteos Graviton', muscular_group: muscular_group },
        { name: 'Glúteos Máquina', muscular_group: muscular_group },
        { name: 'Glúteos Smith', muscular_group: muscular_group },
        { name: 'Glúteos Cross', muscular_group: muscular_group },
        { name: 'Elevação Pélvica Barra', muscular_group: muscular_group },
        { name: 'Elevação Pélvica Halter', muscular_group: muscular_group },
        { name: 'Elevação Pélvica Anilha', muscular_group: muscular_group },
        { name: 'Elevação Pélvica Smith', muscular_group: muscular_group },
        { name: 'Cadeira Abdutora', muscular_group: muscular_group }
      ]
    )
  end

  def calf
    muscular_group = MuscularGroup.find_by(name: 'Panturrilha')
    Exercise.create(
      [
        { name: 'Gêmeos Em Pé Máquina', muscular_group: muscular_group },
        { name: 'Gêmeos Em Pé Hack', muscular_group: muscular_group },
        { name: 'Gêmeos Em Pé Smith', muscular_group: muscular_group },
        { name: 'Gêmeos Em Pé Livre', muscular_group: muscular_group },
        { name: 'Gêmeos Sentado Máquina', muscular_group: muscular_group },
        { name: 'Gêmeos Sentado Smith', muscular_group: muscular_group },
        { name: 'Gêmeos Sentado Livre', muscular_group: muscular_group },
        { name: 'Gêmeos Leg Press', muscular_group: muscular_group }
      ]
    )
  end

  def abdomen
    muscular_group = MuscularGroup.find_by(name: 'Abdomên')
    Exercise.create(
      [
        { name: 'Supra', muscular_group: muscular_group },
        { name: 'Infra', muscular_group: muscular_group },
        { name: 'Oblíquos', muscular_group: muscular_group },
        { name: 'Prancha', muscular_group: muscular_group },
        { name: 'Extensão Lombar', muscular_group: muscular_group }
      ]
    )
  end
end
