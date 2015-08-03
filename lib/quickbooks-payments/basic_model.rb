module Quickbooks::Payments
  class BasicModel
    attr_accessor :json

    def initialize json = {}
      self.json = json
    end
  end
end
