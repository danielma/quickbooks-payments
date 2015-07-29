require 'spec_helper'

RSpec.describe Quickbooks::Payments do
  it 'takes access_token' do
    described_class.access_token = 'token'
    expect(described_class.access_token).to eq 'token'
  end
end
