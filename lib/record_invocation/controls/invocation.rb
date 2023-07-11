module RecordInvocation
  module Controls
    module Invocation
      def self.example
        parameters = {}
        parameters[:some_parameter] = 1
        parameters[:some_other_parameter] = 11

        invocation = ::Invocation.new(method_name, parameters)

        invocation
      end

      def self.method_name
        :some_method
      end
    end
  end
end
