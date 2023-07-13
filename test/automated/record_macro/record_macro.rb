require_relative '../automated_init'

context "Record Macro" do
  recorder = RecordInvocation::Controls::Recorder.example

  control_block = RecordInvocation::Controls::Recorder::Example.some_block

  result = recorder.some_recorded_method(
    :some_arg,
    :some_optional_arg,
    :some_multiple_assignment_arg,
    :some_other_multiple_assignment_arg,
    some_keyword_parameter: :some_keyword_value,
    some_optional_keyword_parameter: :some_optional_keyword_value,
    some_multiple_assignment_keyword_parameter: :some_multiple_assignment_keyword_value,
    some_other_multiple_assignment_keyword_parameter: :some_other_multiple_assignment_keyword_value,
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

    control_arguments = {
      :some_parameter => :some_arg,
      :some_optional_paramter => :some_optional_arg,
      :some_multiple_assignment_parameter => [
        :some_multiple_assignment_arg, :some_other_multiple_assignment_arg
      ],
      :some_keyword_parameter => :some_keyword_value,
      :some_optional_keyword_parameter => :some_optional_keyword_value,
      :some_multiple_assignment_keyword_parameter => {
        :some_multiple_assignment_keyword_parameter => :some_multiple_assignment_keyword_value,
        :some_other_multiple_assignment_keyword_parameter => :some_other_multiple_assignment_keyword_value
      },
      :some_block => control_block
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

