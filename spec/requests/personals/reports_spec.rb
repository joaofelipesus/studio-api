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
end
