RSpec.shared_context 'setup access_token' do
  let(:access_token) do
    token = instance_double OAuth::AccessToken
    %w(get post put delete head).each do |meth|
      resp = instance_double Net::HTTPOK
      allow(resp).to receive(:body).and_return({}.to_json)
      allow(token).to receive(meth).and_return(resp)
    end
    token
  end

  before do
    Quickbooks::Payments.access_token = access_token
  end
end
