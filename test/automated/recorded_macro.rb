require_relative 'automated_init'

context "Recorded Macro" do
  recorder = Controls::Recorder.example

  result = recorder.some_recorded_method

  invocation = recorder.records[0]
  recorded = invocation.method_name == :some_recorded_method

  detail "Result: #{result.inspect}"
  detail "Records: #{recorder.records.inspect}"

  test "Result" do
    assert(result == :some_result)
  end

  context "Invocation" do
    test "Recorded" do
      assert(recorded)
    end
  end
end
