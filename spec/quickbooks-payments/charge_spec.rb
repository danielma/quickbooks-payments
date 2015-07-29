require 'spec_helper'

RSpec.describe Quickbooks::Payments::Charge do
  include_context 'setup access_token'

  describe 'class methods' do
    describe '.create' do
      let(:options)  { {} }
      subject(:call) { described_class.create options }

      it 'returns a charge object' do
        expect(call).to be_a described_class
      end

      it 'makes a request' do
        expect(Quickbooks::Payments::Request).to receive(:post)
        call
      end
    end
  end

  describe 'instance methods' do
  end
end
