module Quickbooks::Payments
  class NoAccessTokenError < RuntimeError; end

  class NoTokenError < ArgumentError; end
  class NoCurrencyError < ArgumentError; end
  class NoAmountError < ArgumentError; end
end
