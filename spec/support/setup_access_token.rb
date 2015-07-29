RSpec.shared_context 'setup access_token' do
  let(:access_token) do
    token = instance_double OAuth::AccessToken
    %w(get post put delete head).each do |meth|
      allow(token).to receive(meth).and_return({})
    end
    token
  end

  before do
    Quickbooks::Payments.access_token = access_token
  end
end
