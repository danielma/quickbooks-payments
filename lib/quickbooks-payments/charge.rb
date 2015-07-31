module Quickbooks::Payments
  class Charge < BasicModel
    @@root_url = '/quickbooks/v4/payments/charges'

    class << self
      def create options = {}
        response = Quickbooks::Payments::Request.post @@root_url, options

        Charge.new response
      end
    end
  end
end
