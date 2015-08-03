module Quickbooks::Payments
  class Charge < BasicModel
    @@root_url = '/quickbooks/v4/payments/charges'

    class << self
      def create options = {}
        validate_options options

        response = Quickbooks::Payments::Request.post @@root_url, options

        Charge.new response
      end

      private

      def validate_options options = {}
        options = options.symbolize_keys

        raise NoTokenError if options[:token].nil?
        raise NoCurrencyError if options[:currency].nil?
        raise NoAmountError if options[:amount].nil?
      end
    end
  end
end
