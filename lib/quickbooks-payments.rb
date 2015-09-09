require 'oauth'
require 'json'
require 'time'

module Quickbooks; end

require_relative 'quickbooks-payments/utils'
require_relative 'quickbooks-payments/errors'
require_relative 'quickbooks-payments/basic_model'
require_relative 'quickbooks-payments/charge'
require_relative 'quickbooks-payments/request'

module Quickbooks
  module Payments
    class << self
      attr_accessor :access_token
    end
  end
end
