# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentPlans::CreateService do
  describe '#call' do
    let(:student) { create(:student) }
    let(:plan) { create(:plan, name: 'Trimestral', duration_in_months: 3) }

    context 'when params are ok' do
      let(:student_plan) { StudentPlan.last }
      let(:params) do
        {
          student_id: student.id,
          plan_id: plan.id,
          started_at: '2022-01-01'
        }
      end

      it 'creates a new student plan' do
        expect do
          described_class.call(params:)
        end.to change(StudentPlan, :count).by(1)
      end

      it 'set status as progress' do
        described_class.call(params:)

        expect(student_plan.status).to match('progress')
      end

      it 'set finished_at date' do
        described_class.call(params:)

        expect(student_plan.finished_at.to_s).to match('2022-04-01')
      end
    end

    context 'when params has problems' do
      let(:error_message) { 'A validação falhou: Aluno é obrigatório(a)' }
      let(:params) do
        {
          plan_id: plan.id,
          started_at: '2022-01-01'
        }
      end

      it 'returns a student plan object with error message' do
        response = described_class.call(params:)
        expect(response.errors.full_messages).to match([error_message])
      end
    end
  end
end
