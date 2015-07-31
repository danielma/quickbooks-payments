require 'oauth'

require 'quickbooks-payments/errors'
require 'quickbooks-payments/basic_model'
require 'quickbooks-payments/charge'
require 'quickbooks-payments/request'

module Quickbooks
  module Payments
    class << self
      attr_accessor :access_token
    end
  end
end
