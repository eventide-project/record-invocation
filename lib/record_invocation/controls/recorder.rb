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

      module RecordMacro
        def self.example
          Example.build(some_block)
        end

        def self.some_block
          @some_block ||= Proc.new {}
        end

        class Example
          include ::RecordInvocation

          attr_accessor :some_block

          def self.build(some_block)
            instance = new
            instance.some_block = some_block
            instance
          end

          record def some_recorded_method(
            some_parameter,
            some_optional_paramter=nil,
            *some_multiple_assignment_parameter,
            some_keyword_parameter:,
            some_optional_keyword_parameter: nil,
            **some_multiple_assignment_keyword_parameter,
            &some_block
          )
            :some_result
          end
        end

        module UnnamedParameters
          def self.example
            Example.build(some_block)
          end

          def self.some_block
            @some_block ||= Proc.new {}
          end

          class Example
            include ::RecordInvocation

            attr_accessor :some_block

            def self.build(some_block)
              instance = new
              instance.some_block = some_block
              instance
            end

            record def some_recorded_method(
              *,
              **,
              &
            )
            end
          end
        end
      end
    end
  end
end
