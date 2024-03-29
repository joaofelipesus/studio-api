# frozen_string_literal: true

RSpec.describe StudentsQuery do
  describe '#call' do
    let(:personal) { create(:personal) }

    before do
      create(:student, personal:, name: 'Charmander')
      create(:student, personal:, name: 'Charmeleon')
      create(:student, personal:, name: 'Charizard')
      create(:student, name: 'Shinji Ikari')
      create(:student, name: 'Asuka Langley')
    end

    it 'renturns student paginated' do
      params = {
        personal_id: personal.id,
        page: 1
      }
      expect(described_class.call(params:)[:students].size).to match(3)
      expect(described_class.call(params:)[:meta]).to match(
        {
          total_pages: 1,
          current_page: 1
        }
      )
    end

    context 'when searching by name' do
      before do
        create(:student, personal:, name: 'asuka ikari')
        create(:student, personal:, name: 'shinji ikari')
      end

      it 'renturns students which name matches with params[:name]' do
        params = {
          personal_id: personal.id,
          page: 1,
          name: 'ikari'
        }
        expect(described_class.call(params:)[:students].size).to match(2)
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
