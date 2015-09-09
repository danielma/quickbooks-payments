module Quickbooks
  module Payments
    # Basic JSON backed model
    class BasicModel
      attr_accessor :json

      def initialize(json = {})
        self.json = json

        json.each do |key, value|
          setter = "#{key}="
          send(setter, value) if respond_to?(setter)
        end
      end

      # Getters

      def to_json
        instance_variables.each_with_object({}) do |variable, sum|
          sum[variable[1..-1]] = instance_variable_get variable
        end.to_json
      end
    end
  end
end
