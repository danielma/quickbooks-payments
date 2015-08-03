require 'spec_helper'

module Quickbooks::Payments
  class BasicModel
    def _fakekey=(val)
    end
  end
end

RSpec.describe Quickbooks::Payments::BasicModel do
  describe 'class methods' do
    describe 'initialize' do
      let(:options) { { "_fakekey" => :val } }
      subject(:call) { described_class.new options }

      it 'sets json to incoming hash' do
        expect(call.json).to eq options
      end
    end
  end

  describe 'instance methods' do
    let(:options) { { "token" => "abcdef" } }
    subject(:instance) { described_class.new options }
  end
end
