# frozen_string_literal: true

class StudentBuilder
  def initialize(params)
    @params = params
  end

  def build
    student = Student.new(params)
    student.user.attributes = { kind: :student, password: random_password }
    student
  end

  private

  attr_reader :params

  def random_password
    SecureRandom.hex(4)
  end
end
