module RecordInvocation
  module Controls
    module Recorder
      def self.example
        Example.new
      end

      class Example
        # include ::RecordInvocation

        # record
        def some_recorded_method(
          some_parameter,
          some_optional_paramter=nil,
          *,
          some_keyword_parameter:,
          some_optional_keyword_parameter: nil,
          **,
          &some_block
        )
          :some_result
        end

        def some_method
          record_invocation(binding)
        end

        # RecordInvocation
        # mimic
        # <---
        # RecordInvocation::Record (customizable one)
        # Substitute (extended)

        # module Substitute
        #   def some_method
        #     "arisetnrs"
        #   end
        # end
      end
    end
  end
end
