require_relative "../../automated_init"

context "Query" do
  context "Invocations" do
    context "No Arguments" do
      invocation = RecordInvocation::Controls::Invocation.example

      context "Recorded" do
        recorder = RecordInvocation::Controls::Recorder.example

        recorder.record(invocation)
        recorder.record(invocation)

        retrieved_invocations = recorder.invocations

        test "All retrieved" do
          assert(retrieved_invocations == [invocation, invocation])
        end
      end

      context "Not Recorded" do
        recorder = RecordInvocation::Controls::Recorder.example

        retrieved_invocations = recorder.invocations

        test "Not retrieved" do
          assert(retrieved_invocations.empty?)
        end
      end
    end
  end
end
