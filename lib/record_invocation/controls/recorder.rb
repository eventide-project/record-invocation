module RecordInvocation
  module Controls
    module Recorder
      def self.example
        Example.new
      end

      class Example
        include ::RecordInvocation

        def some_method
          record_invocation(binding)
        end
      end
    end
  end
end
