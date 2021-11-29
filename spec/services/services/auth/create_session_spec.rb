# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Auth::CreateSession do
  describe '#call' do
    subject { described_class.new(authorization: authorization) }

    context 'when when received a token' do
      context 'when token is invalid' do
        let(:authorization) { 'Bearer 1q2w3e4r' }

        it { expect { subject.call }.to raise_error(JWT::DecodeError) }
      end

      context 'when token is valid' do
        let!(:user) { create(:user) }
        let(:jwt_token) { Services::Auth::JwtHandler.encode({ user_id: user.id }) }
        let(:authorization) { "Bearer #{jwt_token}" }

        it { expect { subject.call }.not_to raise_error }
        it { expect(subject.call).to be_a User }
      end
    end

    context 'when dont receive token' do
      let(:authorization) { '' }

      it { expect { subject.call }.to raise_error(JWT::DecodeError) }
    end
  end
end
