require_relative 'automated_init'

context "Record Macro" do
  recorder = Controls::Recorder.example

  result = recorder.some_recorded_method(
    :some_arg,
    :some_optional_arg,
    :some_multiple_assignment_arg,
    :some_other_multiple_assignment_arg,
    some_keyword_parameter: :some_keyword_value,
    some_optional_keyword_parameter: :some_optional_keyword_value,
    some_multiple_assignment_keyword_parameter: :some_multiple_assignment_keyword_value,
    some_other_multiple_assignment_keyword_parameter: :some_other_multiple_assignment_keyword_value
  ) do
    nil
  end

  module Substitute
    include RecordInvocation

    record def some_recorded_method(...)
      puts "FOO"
    end
  end

  recorder.extend(Substitute)

  pp (class << recorder
    self
  end).ancestors

  result = recorder.some_recorded_method(
    :some_arg,
    :some_optional_arg,
    :some_multiple_assignment_arg,
    :some_other_multiple_assignment_arg,
    some_keyword_parameter: :some_keyword_value,
    some_optional_keyword_parameter: :some_optional_keyword_value,
    some_multiple_assignment_keyword_parameter: :some_multiple_assignment_keyword_value,
    some_other_multiple_assignment_keyword_parameter: :some_other_multiple_assignment_keyword_value
  ) do
    nil
  end

  pp recorder.records

  # invocation = recorder.records[0]
  # recorded = invocation.method_name == :some_recorded_method
  #
  # comment "Result: #{result.inspect}"
  # comment "Records: #{recorder.records.pretty_inspect}"
  #
  # test "Result" do
  #   assert(result == :some_result)
  # end
  #
  # context "Invocation" do
  #   test "Recorded" do
  #     assert(recorded)
  #   end
  # end
end
