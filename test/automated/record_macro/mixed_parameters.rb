require_relative '../automated_init'

context "Record Macro" do
  context "Mixed Parameters" do
    recorder = RecordInvocation::Controls::Recorder::RecordMacro.example

    control_block = proc { }

    result = recorder.some_recorded_method(
      :some_arg,
      :some_optional_arg,
      :some_multiple_assignment_arg,
      :some_other_multiple_assignment_arg,
      some_keyword_parameter: :some_keyword_arg,
      some_optional_keyword_parameter: :some_optional_keyword_arg,
      some_multiple_assignment_keyword_parameter: :some_multiple_assignment_keyword_arg,
      some_other_multiple_assignment_keyword_parameter: :some_other_multiple_assignment_keyword_arg,
      &control_block
    )

    invocation = recorder.records[0]

    detail "Result: #{result.inspect}"
    detail "Invocation: #{invocation.pretty_inspect}"

    test "Result is preserved" do
      assert(result == :some_result)
    end

    context "Invocation" do
      recorded = (invocation.method_name == :some_recorded_method)

      test "Recorded" do
        assert(recorded)
      end

      context "Arguments" do
        arguments = invocation.arguments

        context "Positional" do
          value = arguments[:some_parameter]

          test "Value" do
            assert(value == :some_arg)
          end
        end

        context "Optional Positional" do
          value = arguments[:some_optional_parameter]

          test "Value" do
            assert(value == :some_optional_arg)
          end
        end

        context "Multiple Assignment" do
          value = arguments[:some_multiple_assignment_parameter]

          test "Value" do
            assert(value == [:some_multiple_assignment_arg, :some_other_multiple_assignment_arg])
          end
        end

        context "Keyword" do
          value = arguments[:some_keyword_parameter]

          test "Value" do
            assert(value == :some_keyword_arg)
          end
        end

        context "Optional Keyword" do
          value = arguments[:some_optional_keyword_parameter]

          test "Value" do
            assert(value == :some_optional_keyword_arg)
          end
        end

        context "Multiple Assignment Keyword Parameters" do
          value = arguments[:some_multiple_assignment_keyword_parameter]

          test "Value" do
            assert(value == {
              some_multiple_assignment_keyword_parameter: :some_multiple_assignment_keyword_arg,
              some_other_multiple_assignment_keyword_parameter: :some_other_multiple_assignment_keyword_arg
             })
          end
        end

        context "Block" do
          value = arguments[:some_block]

          test "Value" do
            assert(value == control_block)
          end
        end
      end
    end
  end
end
