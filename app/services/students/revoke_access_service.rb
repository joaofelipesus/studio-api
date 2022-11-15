# frozen_string_literal: true

module Students
  class RevokeAccessService
    def initialize(student_id:, personal:)
      @student_id = student_id
      @personal = personal
    end

    def self.call(student_id:, personal:)
      new(student_id:, personal:).call
    end

    def call
      return if student.personal_id != personal.id

      student.update!(has_access: false)
      student
    end

    private

    attr_accessor :student_id, :personal

    def student
      Student.find(student_id)
    end
  end
end
