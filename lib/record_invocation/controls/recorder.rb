module RecordInvocation
  module Controls
    module Recorder
      def self.example
        Example.new
      end

      class Example
        include ::RecordInvocation

# if false
#         record def some_recorded_method(
#           some_parameter,
#           some_optional_paramter=nil,
#           *some_multiple_assignment_parameter,
#           some_keyword_parameter:,
#           some_optional_keyword_parameter: nil,
#           **some_multiple_assignment_keyword_parameter,
#           &some_block
#         )
#           :some_result
#         end
# else
        record def some_recorded_method(
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
# end

        # record def some_recorded_method(some_parameter, some_optional_paramter=nil, some_keyword_parameter:, some_optional_keyword_parameter: nil, &some_block)
        #   result = {
        #     some_parameter: some_parameter,
        #     some_optional_paramter: some_optional_paramter,
        #     some_keyword_parameter: some_keyword_parameter,
        #     some_optional_keyword_parameter: some_optional_keyword_parameter,
        #     some_block: some_block
        #   }

        #   result
        # end

        def some_method
          record_invocation(binding)
        end
      end
    end
  end
end
