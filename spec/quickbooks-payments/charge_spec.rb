require 'spec_helper'

RSpec.describe Quickbooks::Payments::Charge do
  include_context 'setup access_token'

  describe 'class methods' do
    describe '.create' do
      let(:default_options) do
        {
          token: 'token',
          amount: '100',
          currency: 'USD'
        }
      end
      let(:options) { {} }

      subject(:call) { described_class.create default_options.merge(options) }

      it 'returns a charge object' do
        expect(call).to be_a described_class
      end

      it 'makes a request' do
        expect(Quickbooks::Payments::Request).to receive(:post).and_return({})
        call
      end

      describe 'attributes' do
        let(:created) { '2014-11-03T16:41:42Z' }

        before do
          resp = instance_double Net::HTTPOK
          allow(resp).to receive(:body).and_return({
            created: created,
            status: 'CAPTURED',
            amount: '10.55',
            currency: 'USD',
            token: 'bFy3h7W3D2tmOfYxl2msnLbUirY=',
            id: 'EMU254189574',
            authCode: '792668',
            capture: true
          }.to_json)
          allow(access_token).to receive(:post).and_return(resp)
        end

        its(:created_at) { is_expected.to eq Time.parse(created) }
        its(:status) { is_expected.to eq described_class::Statuses::CAPTURED }
        its(:amount) { is_expected.to eq '10.55' }
        its(:currency) { is_expected.to eq 'USD' }
        its(:token) { is_expected.to eq 'bFy3h7W3D2tmOfYxl2msnLbUirY=' }
        its(:id) { 'EMU254189574' }
        its(:auth_code) { is_expected.to eq '792668' }
        its(:json) { is_expected.to have_key :created }
      end

      describe 'requires' do
        describe 'token' do
          let(:options) { { token: nil } }

          it 'is required' do
            expect { call }.to raise_error Quickbooks::Payments::NoTokenError
          end
        end

        describe 'amount' do
          let(:options) { { amount: nil } }

          it 'is required' do
            expect { call }.to raise_error Quickbooks::Payments::NoAmountError
          end
        end

        describe 'currency' do
          let(:options) { { currency: nil } }

          it 'is required' do
            expect { call }.to raise_error Quickbooks::Payments::NoCurrencyError
          end
        end
      end

      describe 'allowed_options' do
        it 'allows recognized options' do
          expect { described_class.create default_options }
            .to_not raise_error
        end

        it 'does not allow unrecognized options' do
          expect do
            described_class
              .create default_options.merge(__not_an_option__: 'yeah!')
          end.to raise_error(ArgumentError)
        end
      end
    end
  end
end
