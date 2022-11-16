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
  end

  describe 'GET /students_without_active_plan_count' do
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

  describe 'GET /students_without_active_plan_count' do
    it 'returns current personal students count' do
      personal = create(:personal)

      first_student = create(:student, name: 'Asuka', personal:)
      second_student = create(:student, name: 'Shinji', personal:)
      third_student = create(:student, name: 'Rei', personal:)

      anual_plan = create(:plan, personal:, name: 'Anual')
      mensal_plan = create(:plan, personal:, name: 'Mensal')

      create(:student_plan, student: first_student, plan: anual_plan, status: :progress)
      create(:student_plan, student: second_student, plan: anual_plan, status: :progress)
      create(:student_plan, student: third_student, plan: mensal_plan, status: :progress)

      get(
        '/api/personal/reports/students_plan_relation',
        headers: headers(user: personal.user)
      )

      expect(response.parsed_body).to match(
        {
          'students_plan_relation' => {
            'Anual' => 2,
            'Mensal' => 1
          }
        }
      )
    end
  end

  describe 'GET /students_without_active_plan_count' do
    it 'returns current personal students count' do
      personal = create(:personal)

      travel_to(Time.zone.local(2021, 11, 1))
      create(:student, name: 'Asuka', personal:)
      create(:student, name: 'Shinji', personal:)
      create(:student, name: 'Rei', personal:)
      travel_back

      get(
        '/api/personal/reports/new_students_relation?year=2021',
        headers: headers(user: personal.user)
      )

      expect(response.parsed_body).to match(
        {
          'students_relation' => {
            '11/2021' => 3
          }
        }
      )
    end
  end

  describe 'GET /current_month_invoicing' do
    it 'returns current month invoice' do
      travel_to(Time.zone.local(2021, 11, 1))

      personal = create(:personal)
      plan = create(:plan, personal:, name: 'Anual')
      student = create(:student, name: 'Asuka', personal:)
      student_plan = create(:student_plan, plan:, student:)
      create(:payment, student_plan:, amount: 500, date: '2021-11-10', personal:)

      get(
        '/api/personal/reports/current_month_invoicing',
        headers: headers(user: personal.user)
      )

      expect(response.parsed_body).to match({ 'invoice_value' => '500.0' })
      travel_back
    end
  end
end
