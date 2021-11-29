# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:response_body) { JSON.parse(response.body) }

  describe 'POST /users/login' do
    let(:params) { { email: 'asuka@nerv.com', password: '123123123' } }

    context 'when credentials are valid' do
      let(:login_service) { double(:login_service) }
      let(:token) { '1q2w3e4r' }

      before(:each) do
        allow(Services::Users::Login).to receive(:new)
          .with(email: anything, password: anything).and_return(login_service)

        allow(login_service).to receive(:call).and_return(token)

        post('/api/users/login', params: params)
      end

      it { expect(response).to have_http_status(:ok) }

      it { expect(response_body['token']).to match(token) }
    end

    context 'when credentials are invalid' do
      let(:login_service) { double(:login_service) }

      before(:each) do
        allow(Services::Users::Login).to receive(:new)
          .with(email: anything, password: anything).and_return(login_service)

        allow(login_service).to receive(:call).and_raise(Services::Users::Exceptions::InvalidCredentials)

        post('/api/users/login', params: params)
      end

      it { expect(response).to have_http_status(:forbidden) }

      it { expect(response_body['errors']).to match('Email e/ou senha inválido(s).') }
    end
  end
end
