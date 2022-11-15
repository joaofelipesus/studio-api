# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewStudentsRelationReport do
  describe '#call' do
    context 'when don\'t receive year param' do
      it 'returns students grouped by month and personal using current year' do
        personal = create(:personal)
        travel_to(Time.zone.local(2022, 11, 1))
        create(:student, personal:)
        create(:student, personal:)
        expect(described_class.call(personal:)).to match({ '11/2022' => 2 })
        travel_back
      end
    end

    context 'when receive year param' do
      it 'returns students grouped by month and personal using current year' do
        personal = create(:personal)
        travel_to(Time.zone.local(2021, 11, 1))
        create(:student, personal:)
        create(:student, personal:)
        travel_back
        expect(described_class.call(personal:, year: '2021')).to match({ '11/2021' => 2 })
      end
    end
  end
end
