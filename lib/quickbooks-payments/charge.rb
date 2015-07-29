module Quickbooks::Payments
  class Charge
    @@root_url = '/quickbooks/v4/payments/charges'

    class << self
      def create options = {}
        response = Quickbooks::Payments::Request.post @@root_url, options

        Charge.new response
      end
    end

    def initialize attrs = {}
      attrs.to_h.each do |k, v|
        send "#{k}=", v
      end
    end
  end
end
