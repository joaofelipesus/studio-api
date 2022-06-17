# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Pagination::Index do
  describe '#call' do
    let(:params) { {} }
    let(:klass) { Exercise }

    before :each do
      create(:exercise, name: 'asuka')
      create(:exercise, name: 'shinji')
      create(:exercise, name: 'rei')
    end

    subject { described_class.new(klass:, params:) }

    context 'when params contains name param' do
      let(:params) { { name: 'a' } }

      it 'calls search by name' do
        expect(subject.call).to match(
          {
            exercises: [Exercise.find_by(name: 'asuka')],
            total_pages: 1,
            current_page: 1
          }
        )
      end
    end

    context 'when params dont contains name param' do
      let(:response) { subject.call }

      it 'considers all registers' do
        expect(response).to match(
          {
            exercises: anything,
            total_pages: 1,
            current_page: 1
          }
        )
      end

      it { expect(response[:exercises].size).to match(3) }
    end
  end
end
