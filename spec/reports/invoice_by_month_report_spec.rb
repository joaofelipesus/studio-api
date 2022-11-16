# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceByMonthReport do
  describe '#call' do
    let(:personal) { create(:personal) }
    let(:student) { create(:student, personal:) }
    let(:plan) { create(:plan, personal:) }
    let(:student_plan) { create(:student_plan, student:, plan:) }

    context 'when don\'t receive year param' do
      it 'returns students grouped by month and personal using current year' do
        create(:payment, personal:, student_plan:, amount: 150, date: '2022-11-10')

        expect(described_class.call(personal:)).to match({ '11/2022' => 150 })
      end
    end

    context 'when receive year param' do
      it 'returns students grouped by month and personal using current year' do
        create(:payment, personal:, student_plan:, amount: 150, date: '2021-11-10')

        expect(described_class.call(personal:, year: '2021')).to match({ '11/2021' => 150 })
      end
    end
  end
end
