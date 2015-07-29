module Quickbooks::Payments
  class Request
    class << self
      def get *args
        access_token = Quickbooks::Payments.access_token

        raise NoAccessTokenError unless access_token.is_a?(OAuth::AccessToken)

        Quickbooks::Payments.access_token.get(*args)
      end
    end
  end
end
