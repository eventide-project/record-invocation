module RecordInvocation
  module Controls
    module Recorder
      def self.example
        Example.new
      end

      class Example
        include ::RecordInvocation

        recorded :some_recorded_method do |some_parameter, some_other_parameter:|
          :some_result
        end

        def some_method
          record_invocation(binding)
        end
      end
    end
  end
end
