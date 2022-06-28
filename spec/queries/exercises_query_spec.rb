# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExercisesQuery do
  describe '#call' do
    let(:personal) { create(:personal) }
    let!(:create_exercises) { 3.times { create(:exercise, personal:) } }
    let!(:create_more_exercises) { 2.times { create(:exercise) } }

    it 'renturns exercises paginated' do
      params = {
        personal_id: personal.id,
        page: 1
      }
      expect(described_class.call(params:)[:exercises].size).to match(3)
      expect(described_class.call(params:)[:meta]).to match(
        {
          total_pages: 1,
          current_page: 1
        }
      )
    end

    context 'when searching by name' do
      before do
        create(:exercise, personal:, name: 'supino barra')
        create(:exercise, personal:, name: 'supino halter')
      end

      it 'renturns exercises which name matches with params[:name]' do
        params = {
          personal_id: personal.id,
          page: 1,
          name: 'supino'
        }
        expect(described_class.call(params:)[:exercises].size).to match(2)
        expect(described_class.call(params:)[:meta]).to match(
          {
            total_pages: 1,
            current_page: 1
          }
        )
      end
    end
  end
end
