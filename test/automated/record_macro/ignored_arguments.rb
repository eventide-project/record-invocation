require_relative "../automated_init"

context "Record Macro" do
  context "Ignored Parameters" do
    recorder = RecordInvocation::Controls::Recorder::RecordMacro::IgnoredParameters.example

    control_block = proc { }

    recorder.some_recorded_method(
      :some_ignored_arg,
      :some_other_ignored_arg,
      some_ignored_keyword_parameter: :some_ignored_keyword_arg,
      some_other_ignored_keyword_parameter: :some_other_ignored_keyword_arg,
      &control_block
    )

    invocation = recorder.records[0]

    detail "Invocation: #{invocation.pretty_inspect}"

    context "Invocation" do
      recorded = (invocation.method_name == :some_recorded_method)

      test "Recorded" do
        assert(recorded)
      end

      context "Arguments" do
        arguments = invocation.arguments

        context "Ignored" do
          value = arguments[:*]

          test "Value" do
            assert(value == [:some_ignored_arg, :some_other_ignored_arg])
          end
        end

        context "Ignored Keyword Parameters" do
          value = arguments[:**]

          test "Value" do
            assert(value == {
              some_ignored_keyword_parameter: :some_ignored_keyword_arg,
              some_other_ignored_keyword_parameter: :some_other_ignored_keyword_arg
             })
          end
        end

        context "Block" do
          value = arguments[:&]

          test "Value" do
            assert(value == control_block)
          end
        end
      end
    end
  end
end
