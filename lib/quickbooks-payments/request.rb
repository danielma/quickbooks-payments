module Quickbooks
  module Payments
    # Create Requests
    class Request
      class << self
        %w(get delete head).each do |meth|
          define_method meth do |endpoint, headers = {}|
            request meth, endpoint, headers
          end
        end

        %w(post put).each do |body_meth|
          define_method body_meth do |endpoint, body = '', headers = {}|
            request_with_body body_meth, endpoint, body, headers
          end
        end

        private

        def root
          if Quickbooks::Payments.sandbox_mode
            'https://sandbox.api.intuit.com'
          else
            'https://api.intuit.com'
          end
        end

        def get_url(relative_url = '')
          "#{root}#{relative_url}"
        end

        def ensure_access_token(method)
          @access_token = Quickbooks::Payments.access_token

          fail NoAccessTokenError unless @access_token.respond_to?(method)
        end

        def request(method, endpoint, headers = {})
          ensure_access_token method

          parse_json @access_token.public_send(method, get_url(endpoint),
                                               default_headers.merge(headers))
        end

        def request_with_body(method, endpoint, body = '', headers = {})
          ensure_access_token method

          body = body.to_json unless body.respond_to?(:to_str)

          parse_json @access_token.public_send(method, get_url(endpoint), body,
                                               default_headers.merge(headers))
        end

        def parse_json(response)
          JSON.parse response.body
        rescue
          { error: 'JSON_UNPARSEABLE', body: response.body, response: response }
        end

        def default_headers
          {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        end
      end
    end
  end
end
