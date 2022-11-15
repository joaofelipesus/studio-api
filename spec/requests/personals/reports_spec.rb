# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Personals::Reports', type: :request do
  describe 'GET /students_count' do
    it 'returns current personal students count' do
      personal = create(:personal)
      create(:student, name: 'Asuka', personal:)
      create(:student, name: 'Shinji', personal:)
      create(:student, name: 'Rei', personal:)
      second_personal = create(:personal)
      create(:student, name: 'Other student name', personal: second_personal)

      get('/api/personal/reports/students_count', headers: headers(user: personal.user))

      expect(response.parsed_body).to match({ 'students_count' => 3 })
    end

    it 'returns current personal students count' do
      personal = create(:personal)
      student = create(:student, name: 'Asuka', personal:)
      create(:student, name: 'Shinji', personal:)
      create(:student, name: 'Rei', personal:)
      plan = create(:plan, personal:)
      create(:student_plan, student:, plan:, status: :progress)
      second_personal = create(:personal)
      create(:student, name: 'Other student name', personal: second_personal)

      get(
        '/api/personal/reports/students_without_active_plan_count',
        headers: headers(user: personal.user)
      )

      expect(response.parsed_body).to match({ 'students_without_active_plan_count' => 2 })
    end
  end
end
