require 'spec_helper'

RSpec.describe Quickbooks::Payments::Request do
  describe 'class methods' do
    describe 'get' do
      let(:call) { described_class.get args }
      let(:args) { {} }

      it 'fails without access_token on parent' do
        Quickbooks::Payments.access_token = nil
        expect { call }.to raise_error(Quickbooks::Payments::NoAccessTokenError)
      end
    end
  end
end
