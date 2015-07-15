require 'oauth'
require 'awesome_print'

consumer_key    = '***REMOVED***'
consumer_secret = '***REMOVED***'

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

