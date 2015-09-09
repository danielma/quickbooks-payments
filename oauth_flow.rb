# rubocop:disable all

require 'oauth'
require 'awesome_print'

credentials_txt = File.read('./CREDENTIALS')

credentials = {}

credentials_txt.split.each do |line|
  key, value = line.split('=')
  credentials[key] = value
end

consumer_key    = credentials['CONSUMER_KEY']
consumer_secret = credentials['CONSUMER_SECRET']

consumer = OAuth::Consumer.new consumer_key, consumer_secret,
  site:               'https://oauth.intuit.com',
  request_token_path: '/oauth/v1/get_request_token',
  authorize_url:      'https://appcenter.intuit.com/Connect/Begin',
  access_token_path:  '/oauth/v1/get_access_token'

request_token = consumer.get_request_token(oauth_callback: 'http://anyurliwant.dev/yeahdude/')
ap "https://appcenter.intuit.com/Connect/Begin?oauth_token=#{request_token.token}"

ap 'give me verifier'
verifier = gets.chomp

at = request_token.get_access_token oauth_verifier: verifier

ap 'token'
ap at.token
ap 'secret'
ap at.secret
