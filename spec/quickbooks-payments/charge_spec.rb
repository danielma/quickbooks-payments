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
        expect(Quickbooks::Payments::Request).to receive(:post)
        call
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
    end
  end

  describe 'instance methods' do
  end
end
