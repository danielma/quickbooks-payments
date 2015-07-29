require 'spec_helper'

RSpec.describe Quickbooks::Payments::Request do
  describe 'class methods' do
    let(:args)  { ['/path'] }
    let(:token) do
      token = instance_double OAuth::AccessToken
      %w(get post put delete head).each do |meth|
        allow(token).to receive(meth).and_return true
      end
      token
    end

    %w(get post put delete head).each do |meth|
      describe meth do
        let(:call) { described_class.send meth, *args }

        it 'fails without access_token' do
          Quickbooks::Payments.access_token = nil
          expect { call }.to raise_error(Quickbooks::Payments::NoAccessTokenError)
        end

        it 'sends args to access_token' do
          Quickbooks::Payments.access_token = token
          expect(Quickbooks::Payments.access_token).to receive(meth).with(*args)
          call
        end
      end
    end
  end
end
