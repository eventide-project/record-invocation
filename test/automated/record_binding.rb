require_relative 'automated_init'

context "Record Binding" do
  recorder = Controls::Recorder.example

  recorder.some_method

  invocation = recorder.records[0]
  recorded = invocation.method_name == :some_method

  detail "Records: #{recorder.records.pretty_inspect}"

  context "Invocation" do
    test "Recorded" do
      assert(recorded)
    end
  end
end
