require 'oauth'
require 'quickbooks-payments/charge'

module Quickbooks
  module Payments
    class << self
      attr_accessor :access_token
    end
  end
end
