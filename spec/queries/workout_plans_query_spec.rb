# frozen_string_literal: true

RSpec.describe WorkoutPlansQuery do
  describe '#call' do
    let(:personal) { create(:personal) }
    let!(:create_workout_plans) { 3.times { create(:workout_plan, personal:) } }
    let!(:create_more_workout_plans) { 2.times { create(:workout_plan) } }

    it 'renturns student paginated' do
      params = {
        personal_id: personal.id,
        page: 1
      }
      expect(described_class.call(params:)[:workout_plans].size).to match(3)
      expect(described_class.call(params:)[:meta]).to match(
        {
          total_pages: 1,
          current_page: 1
        }
      )
    end

    context 'when searching by name' do
      before do
        create(:workout_plan, personal:, name: 'asuka ikari')
        create(:workout_plan, personal:, name: 'shinji ikari')
      end

      it 'renturns workout_plans which name matches with params[:name]' do
        params = {
          personal_id: personal.id,
          page: 1,
          name: 'ikari'
        }
        expect(described_class.call(params:)[:workout_plans].size).to match(2)
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
