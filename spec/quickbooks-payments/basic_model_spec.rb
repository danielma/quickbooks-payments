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

      it 'sets each key value pair' do
        expect_any_instance_of(described_class).to receive("_fakekey=").with(:val)
        call
      end
    end
  end
end
