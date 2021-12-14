# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Pagination::SearchByName do
  describe '#call' do
    let!(:asuka) { create(:exercise, name: 'asuka') }

    before(:each) do
      create(:exercise, name: 'shinji')
      create(:exercise, name: 'rei')
    end

    subject { described_class.new(klass: Exercise, name_pattern: 'asu') }

    it 'returns a array with elements with match to received pattern' do
      expect(subject.call).to match([asuka])
    end
  end
end
