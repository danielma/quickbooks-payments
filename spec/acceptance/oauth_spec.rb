require 'oauth'

credentials_txt = File.read('./CREDENTIALS')

credentials = {}

credentials_txt.split.each do |line|
  key, value = line.split('=')
  credentials[key] = value
end

RSpec.describe Quickbooks::Payments do
  let(:consumer_key)    { '***REMOVED***' }
  let(:consumer_secret) { '***REMOVED***' }

  let(:consumer) do
    OAuth::Consumer.new consumer_key, consumer_secret,
      site:               'https://oauth.intuit.com',
      request_token_path: '/oauth/v1/get_request_token',
      authorize_url:      'https://appcenter.intuit.com/Connect/Begin',
      access_token_path:  '/oauth/v1/get_access_token'
  end

  let(:op_consumer) do
    OAuth::Consumer.new consumer_key, consumer_secret,
      site:               'https://sandbox.api.intuit.com',
      request_token_path: '/oauth/v1/get_request_token',
      authorize_url:      'https://appcenter.intuit.com/Connect/Begin',
      access_token_path:  '/oauth/v1/get_access_token'
  end

  it 'OAuth' do
    access_token = OAuth::AccessToken.new(op_consumer, credentials['TOKEN'], credentials['SECRET'])
    ap access_token
    ap access_token.get('/quickbooks/v4/customers/1/cards')
  end
end
