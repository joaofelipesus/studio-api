# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Paginator do
  describe '#call' do
    let(:page) { nil }
    let(:order_by) { nil }
    let(:data) { User.all }

    subject { described_class.new(data: data, response_key: :users, page: page, order_by: order_by) }

    it { expect(subject.call).to be_a Hash }
    it { expect(subject.call.keys).to contain_exactly(:users, :total_pages, :current_page) }

    context 'when has more than max pages elements limit' do
      before { 15.times { create(:user) } }

      context 'when send page param' do
        it 'returns only ten elements and dont send page' do
          expect(subject.call[:users].size).to match(10)
        end
      end

      context 'when send page param' do
        let(:page) { 2 }
        it 'returns received page elements' do
          expect(subject.call[:users].size).to match(5)
        end
      end
    end

    context 'when has less than ten registers' do
      before { 3.times { create(:user) } }

      it 'returns all elements' do
        expect(subject.call[:users].size).to match(3)
      end
    end

    describe 'param order_by' do
      before do
        create(:user, email: 'rei@nerv.com')
        create(:user, email: 'asuka@nerv.com')
        create(:user, email: 'shinji@nerv.com')
      end

      context 'when pass a order_by param' do
        let(:order_by) { { email: :asc } }

        it 'orders by name' do
          expect(subject.call[:users].first.email).to match('asuka@nerv.com')
        end
      end

      context 'when doesnt send order_by param' do
        it 'orders by created at' do
          expect(subject.call[:users].first.email).to match('shinji@nerv.com')
        end
      end
    end
  end
end
