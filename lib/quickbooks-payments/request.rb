module Quickbooks::Payments
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

      def ensure_access_token method
        @access_token = Quickbooks::Payments.access_token

        raise NoAccessTokenError unless @access_token.respond_to?(method)
      end

      def request method, endpoint, headers = {}
        ensure_access_token method

        @access_token.public_send method, endpoint, headers
      end

      def request_with_body method, endpoint, body = '', headers = {}
        ensure_access_token method

        @access_token.public_send method, endpoint, body, headers
      end
    end
  end
end
