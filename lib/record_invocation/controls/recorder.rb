module RecordInvocation
  module Controls
    module Recorder
      def self.example
        Example.new
      end

      class Example
        include ::RecordInvocation

## Macro use
        # recorded :some_recorded_method do |p1, p2:, ...|
        #   :some_result
        # end

        def some_method
          record_invocation(binding)
        end
      end
    end
  end
end
