# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::LoginService do
  describe '#call' do
    let(:invalid_credentials_error) { Users::Exceptions::InvalidCredentials }
    let(:error_message) { 'Email e/ou senha inválido(s).' }
    let(:email) { user.email }
    let(:password) { user.password }
    let(:throws_invalid_credentials_error) do
      expect { subject.call }.to raise_error(invalid_credentials_error).with_message(error_message)
    end

    subject { described_class.new(email:, password:) }

    context 'when received email is present on database' do
      context 'when user is confirmed' do
        let!(:user) { create(:user, password: '123123123', email: 'asuka@nerv.com') }

        context 'when password doesnt match' do
          let(:password) { '1q2w3e4r54t' }

          it { throws_invalid_credentials_error }
        end

        context 'when password is correct' do
          it { expect { subject.call }.not_to raise_error }
          it { expect(subject.call).to be_a String }
        end
      end

      context 'when user isnt confirmed' do
        let!(:user) { create(:user, status: :pending) }
        let(:password) { '1q2w3e4r5t' }

        it { throws_invalid_credentials_error }
      end
    end
    context 'when email doesnt exist on database' do
      let(:email) { 'no@user.com' }
      let(:password) { '123123123' }

      it { throws_invalid_credentials_error }
    end
  end
end
