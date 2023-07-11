require_relative 'automated_init'

context "Record Invocation" do
  recorder = Controls::Recorder.example

  invocation = Controls::Invocation.example

  recorder.record(invocation)

  comment "Records: #{recorder.records.pretty_inspect}"

  context "Invocation" do
    test "Recorded" do
      assert(recorder.records.include?(invocation))
    end
  end
end
