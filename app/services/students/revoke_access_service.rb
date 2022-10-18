# frozen_string_literal: true

module Students
  class RevokeAccessService
    def initialize(student_id:)
      @student_id = student_id
    end

    def self.call(student_id:)
      new(student_id:).call
    end

    def call
      student.update!(has_access: false)
    end

    private

    attr_accessor :student_id

    def student
      Student.find(student_id)
    end
  end
end
