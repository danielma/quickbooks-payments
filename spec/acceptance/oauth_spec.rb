require 'oauth'

credentials_path = './CREDENTIALS'

credentials_txt = if File.exists?(credentials_path)
                    File.read credentials_path
                  else
                    ''
                  end

credentials = credentials_txt.split.each_with_object({}) do |line, sum|
  key, value = line.split('=')
  sum[key] = value
end

RSpec.describe Quickbooks::Payments do
  let(:consumer_key)    { credentials['CONSUMER_KEY'] }
  let(:consumer_secret) { credentials['CONSUMER_SECRET'] }

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

  # this file exists to give you an idea of what the AccessToken code looks like
  # Uncomment this block to try it out
  # it 'is authorized' do
  #   skip 'no credentials' if credentials.empty?
  #
  #   access_token = OAuth::AccessToken.new(op_consumer,
  #                                         credentials['TOKEN'],
  #                                         credentials['SECRET'])
  #   expect { access_token.get('/quickbooks/v4/customers/1/cards').value }
  #     .to_not raise_error
  # end
end
