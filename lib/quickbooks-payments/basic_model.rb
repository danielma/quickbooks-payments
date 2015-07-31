module Quickbooks::Payments
  class BasicModel
    def initialize attrs = {}
      attrs.to_h.each do |k, v|
        send "#{k}=", v
      end
    end
  end
end
