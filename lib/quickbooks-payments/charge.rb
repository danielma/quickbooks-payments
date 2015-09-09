require 'securerandom'

module Quickbooks
  module Payments
    # Represents a charge
    #
    # Create a charge by using `Charge.create()`
    class Charge < BasicModel
      @root_url = '/quickbooks/v4/payments/charges'

      attr_accessor :status, :amount, :currency, :token, :id, :auth_code,
                    :request_id
      attr_reader :created_at

      alias_method :authCode=, :auth_code=

      # Statuses
      class Statuses
        AUTHORIZED = 'AUTHORIZED'
        CAPTURED = 'CAPTURED'
        DECLINED = 'DECLINED'
        CANCELLED = 'CANCELLED'
        SETTLED = 'SETTLED'
        REFUNEDED = 'REFUNDED'
      end

      class << self
        def create(options = {})
          options = validate_options options

          request_id = SecureRandom.uuid

          response = Quickbooks::Payments::Request.post(
            @root_url,
            options,
            'Request-Id' => request_id)

          new response.merge request_id: request_id
        end

        private

        def validate_options(options = {})
          options = options.symbolize_keys

          ensure_required_options options
          verify_allowed_options options

          options
        end

        def ensure_required_options(options)
          fail NoTokenError if options[:token].nil?
          fail NoCurrencyError if options[:currency].nil?
          fail NoAmountError if options[:amount].nil?
        end

        def allowed_options
          @allowed_options ||= %w(token amount currency cardOnFile card context
                                  capture description)
                               .map { |v| [v.to_sym, true] }
                               .to_h
        end

        def verify_allowed_options(options)
          options.keys.each do |k|
            allowed_options.key?(k) ||
              fail(ArgumentError.new, "Unsupported option #{k}")
          end
        end
      end

      def initialize(json = {})
        super

        json.each do |key, value|
          setter = "#{key}="
          send(setter, value) if respond_to?(setter)
        end
      end

      # Setters

      def created_at=(string_or_time)
        @created_at = if string_or_time.is_a?(Time)
                        string_or_time
                      else
                        Time.parse(string_or_time)
                      end
      end

      alias_method :created=, :created_at=
    end
  end
end
