require 'spec_helper'

RSpec.describe Quickbooks::Payments::Request do
  include_context 'setup access_token'

  describe 'class methods' do
    let(:args)  { ['/path'] }

    %w(get delete head).each do |meth|
      describe meth do
        let(:call) { described_class.send meth, *args }

        it 'fails without access_token' do
          Quickbooks::Payments.access_token = nil
          expect { call }.to raise_error(Quickbooks::Payments::NoAccessTokenError)
        end

        it 'sends args to access_token' do
          Quickbooks::Payments.access_token = access_token
          expect(Quickbooks::Payments.access_token).to receive(meth)
            .with(args[0], {})
          call
        end
      end
    end

    %w(post put).each do |meth|
      describe meth do
        let(:call) { described_class.send meth, *args }

        it 'fails without access_token' do
          Quickbooks::Payments.access_token = nil
          expect { call }.to raise_error(Quickbooks::Payments::NoAccessTokenError)
        end

        it 'sends args to access_token' do
          Quickbooks::Payments.access_token = access_token
          expect(Quickbooks::Payments.access_token).to receive(meth)
            .with(args[0], '', {})
          call
        end
      end
    end
  end
end
