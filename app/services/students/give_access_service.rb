# frozen_string_literal: true

module Students
  class GiveAccessService
    def initialize(student_id:, email:)
      @student_id = student_id
      @email = email
    end

    def self.call(student_id:, email:)
      new(student_id:, email:).call
    end

    def call
      user = find_or_create_user
      student.update!(
        has_access: true,
        user:
      )
      send_access_email
    end

    private

    attr_reader :student_id, :email

    def student
      @student ||= Student.find(student_id)
    end

    def find_or_create_user
      return student.user if student.user

      User.create!(
        status: :confirmed,
        kind: :student,
        password:,
        email:,
        name: student.name
      )
    end

    def password
      @password ||= SecureRandom.hex(4)
    end

    def send_access_email
      StudentsMailer.with(
        student:,
        password:
      ).give_access.deliver_later
    end
  end
end
