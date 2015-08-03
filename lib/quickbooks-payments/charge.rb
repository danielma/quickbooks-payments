module Quickbooks::Payments
  class Charge < BasicModel
    @@root_url = '/quickbooks/v4/payments/charges'

    class << self
      def create options = {}
        options = validate_options options

        response = Quickbooks::Payments::Request.post @@root_url, options

        Charge.new response
      end

      private

      def validate_options options = {}
        options = options.symbolize_keys

        ensure_required_options options
        verify_allowed_options options

        options
      end

      def ensure_required_options options
        raise NoTokenError if options[:token].nil?
        raise NoCurrencyError if options[:currency].nil?
        raise NoAmountError if options[:amount].nil?
      end

      def allowed_options
        @allowed_options ||= %w(token amount currency cardOnFile card context capture description)
          .map { |v| [v.to_sym, true ] }
          .to_h
      end

      def verify_allowed_options options
        options.keys.each do |k|
          allowed_options[k] || raise(ArgumentError.new, "Unsupported option #{k}")
        end
      end
    end
  end
end
