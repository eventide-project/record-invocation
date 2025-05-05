require_relative "automated_init"

context "Record Invocation" do
  recorder = RecordInvocation::Controls::Recorder.example

  invocation = RecordInvocation::Controls::Invocation.example

  recorder.record(invocation)

  detail "Records: #{recorder.records.pretty_inspect}"

  context "Invocation" do
    test "Recorded" do
      assert(recorder.records.include?(invocation))
    end
  end
end
