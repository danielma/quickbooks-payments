require 'spec_helper'

RSpec.describe Quickbooks::Payments::Charge do
  include_context 'setup access_token'

  let(:valid_attributes) do
    {
      created: '2014-11-03T16:41:42Z',
      status: 'CAPTURED',
      amount: '10.55',
      currency: 'USD',
      token: 'bFy3h7W3D2tmOfYxl2msnLbUirY=',
      id: 'EMU254189574',
      authCode: '792668',
      capture: true
    }
  end

  describe 'class methods' do
    let(:args) { [] }
    subject(:run) { described_class.send method, *args }

    describe '.create' do
      let(:default_options) do
        {
          token: 'token',
          amount: '100',
          currency: 'USD'
        }
      end
      let(:options) { {} }
      let(:args) { [default_options.merge(options)] }

      let(:method) { 'create' }

      it 'returns a charge object' do
        expect(run).to be_a described_class
      end

      it 'makes a request' do
        expect(Quickbooks::Payments::Request).to receive(:post)
          .with(anything, anything, hash_including('Request-Id'))
          .and_return({})
        run
      end

      describe 'attributes' do
        before do
          resp = instance_double Net::HTTPOK
          allow(resp).to receive(:body).and_return(valid_attributes.to_json)
          allow(access_token).to receive(:post).and_return(resp)
        end

        its(:created_at) do
          is_expected.to eq Time.parse valid_attributes[:created]
        end
        its(:status) { is_expected.to eq described_class::Statuses::CAPTURED }
        its(:amount) { is_expected.to eq '10.55' }
        its(:currency) { is_expected.to eq 'USD' }
        its(:token) { is_expected.to eq 'bFy3h7W3D2tmOfYxl2msnLbUirY=' }
        its(:id) { 'EMU254189574' }
        its(:auth_code) { is_expected.to eq '792668' }
        its(:json) { is_expected.to have_key 'created' }
      end

      describe 'requires' do
        describe 'token' do
          let(:options) { { token: nil } }

          it 'is required' do
            expect { run }.to raise_error Quickbooks::Payments::NoTokenError
          end
        end

        describe 'amount' do
          let(:options) { { amount: nil } }

          it 'is required' do
            expect { run }.to raise_error Quickbooks::Payments::NoAmountError
          end
        end

        describe 'currency' do
          let(:options) { { currency: nil } }

          it 'is required' do
            expect { run }.to raise_error Quickbooks::Payments::NoCurrencyError
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

    describe '.validate_options' do
      let(:method) { 'validate_options' }
      let(:args) { [{ 'string_option' => 'string' }] }

      it 'stringifies keys' do
        expect(described_class).to receive(:ensure_required_options)
          .with(hash_including(:string_option))
        expect(described_class).to receive(:verify_allowed_options)
          .and_return({})

        run
      end
    end
  end
end
