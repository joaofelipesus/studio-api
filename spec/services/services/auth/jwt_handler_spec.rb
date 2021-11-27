# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Auth::JwtHandler do
  describe '#encode' do
    it 'returns a string' do
      expect(described_class.encode({ user_id: 1 })).to be_a String
    end
  end

  describe '#decode' do
    it 'returns a hash with decoded info' do
      token = described_class.encode({ user_id: 1 })
      expect(described_class.decode(token)[:user_id]).to match(1)
    end
  end
end
