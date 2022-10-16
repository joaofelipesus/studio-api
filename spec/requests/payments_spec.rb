# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
  let(:payment_json) do
    {
      'id' => payment.id,
      'amount' => payment.amount.to_s,
      'payment_method' => payment.payment_method,
      'student_plan_id' => payment.student_plan_id,
      'date' => payment.date.to_s
    }
  end

  describe 'GET /api/payments' do
    let!(:create_payments) { 3.times { create(:payment, personal:) } }

    before(:each) { get('/api/payments', headers: headers(user: personal.user)) }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['payments'].size).to match(3) }
    it { expect(response_body['total_pages']).to match(1) }
  end

  describe 'GET /api/payments/:id' do
    before(:each) { get("/api/payments/#{payment_id}", headers: headers(user: personal.user)) }

    context 'when payment exist' do
      let!(:payment) { create(:payment, personal:) }
      let(:payment_id) { payment.id }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body['payment']).to match(payment_json) }
    end

    context 'when payment dont exist' do
      let(:payment_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/payments' do
    let(:student_plan) { create(:student_plan) }
    before(:each) { post('/api/payments', params:, headers: headers(user: personal.user)) }

    context 'when params are ok' do
      let(:params) do
        {
          amount: 150.0,
          payment_method: 'pix',
          student_plan_id: student_plan.id,
          date: Date.current.to_s
        }
      end
      let(:payment) { Payment.last }

      it { expect(response).to have_http_status(:created) }

      it 'returns created payment' do
        expect(response_body['payment']).to match(payment_json)
      end
    end

    context 'when params has errors' do
      let(:student_plan) { create(:student_plan) }
      let(:error_message) { 'A validação falhou: Método de pagamento não pode ficar em branco' }
      let(:params) do
        {
          amount: 150.0,
          payment_method: nil,
          student_plan_id: student_plan.id,
          date: Date.current.to_s
        }
      end

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match([error_message]) }
    end
  end

  describe 'DELETE /api/payments/:id' do
    before(:each) { delete("/api/payments/#{payment_id}", headers: headers(user: personal.user)) }

    context 'when payment exist' do
      let!(:payment) { create(:payment) }
      let(:payment_id) { payment.id }

      it { expect(response).to have_http_status(:ok) }

      it { expect(Payment.count).to match(0) }
    end

    context 'when payment dont exist' do
      let(:payment_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
