# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Auth::JwtEncoder do
  describe '#encode' do
    it 'returns a string' do
      expect(described_class.encode({ user_id: 1 })).to be_a String
    end
  end
end
