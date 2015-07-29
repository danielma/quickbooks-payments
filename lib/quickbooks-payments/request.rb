module Quickbooks::Payments
  class Request
    class << self
      %w(get post put delete head).each do |meth|
        define_method meth do |*args|
          request meth, *args
        end
      end

      private

      def request method, *args
        access_token = Quickbooks::Payments.access_token

        raise NoAccessTokenError unless access_token.respond_to?(method)

        Quickbooks::Payments.access_token.public_send(method, *args)
      end
    end
  end
end
