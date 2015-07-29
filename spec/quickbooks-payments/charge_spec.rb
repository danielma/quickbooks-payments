RSpec.describe Quickbooks::Payments::Charge do
  describe 'class methods' do
    describe '.create' do
      let(:options)  { {} }
      subject(:call) { described_class.create options }

      it 'returns a charge object' do
        expect(call).to be_a described_class
      end
    end
  end

  describe 'instance methods' do
  end
end
