require 'spec_helper'

module Quickbooks
  module Payments
    # stub out a fakekey setter
    class BasicModel
      attr_accessor :token

      def _fakekey=(_)
      end
    end
  end
end

RSpec.describe Quickbooks::Payments::BasicModel do
  describe 'class methods' do
    describe 'initialize' do
      let(:options) { { '_fakekey' => :val } }
      subject(:call) { described_class.new options }

      it 'sets json to incoming hash' do
        expect(call.json).to eq options
      end
    end
  end

  describe 'instance methods' do
    let(:options) { { 'token' => 'abcdef' } }
    let(:instance) { described_class.new options }
    let(:args) { [] }

    subject(:run) { instance.send method, *args }

    describe 'to_json' do
      let(:method) { 'to_json' }

      it { is_expected.to include '"token"' }
      it { is_expected.to_not include '"@token"' }
      it { is_expected.to include options['token'] }
    end
  end
end
