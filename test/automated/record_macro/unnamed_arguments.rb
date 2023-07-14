require_relative '../automated_init'

context "Record Macro" do
  context "Unnamed Parameters" do
    recorder = RecordInvocation::Controls::Recorder::UnnamedParameters.example

    control_block = RecordInvocation::Controls::Recorder::UnnamedParameters.some_block

    recorder.some_recorded_method(
      :some_multiple_assignment_arg,
      :some_other_multiple_assignment_arg,
      some_multiple_assignment_keyword_parameter: :some_multiple_assignment_keyword_value,
      some_other_multiple_assignment_keyword_parameter: :some_other_multiple_assignment_keyword_value,
      &control_block
    )

    invocation = recorder.records[0]

    detail "Invocation: #{invocation.pretty_inspect}"

    context "Invocation" do
      recorded = (invocation.method_name == :some_recorded_method)

      test "Recorded" do
        assert(recorded)
      end

      control_arguments = {
        :* => [
          :some_multiple_assignment_arg, :some_other_multiple_assignment_arg
        ],
        :** => {
          :some_multiple_assignment_keyword_parameter => :some_multiple_assignment_keyword_value,
          :some_other_multiple_assignment_keyword_parameter => :some_other_multiple_assignment_keyword_value
        },
        :& => control_block
      }

      context "Arguments" do
        control_arguments.each do |name, value|
          arg = { name => value }

          invoked = recorder.invoked?(:some_recorded_method, **arg)

          test "#{name.inspect} => #{value.inspect}" do
            assert(invoked)
          end
        end
      end
    end
  end
end
