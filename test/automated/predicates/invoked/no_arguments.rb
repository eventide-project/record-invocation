require_relative "../../automated_init"

context "Predicates" do
  context "Invoked" do
    context "No Arguments" do
      invocation = RecordInvocation::Controls::Invocation.example

      context "Recorded" do
        recorder = RecordInvocation::Controls::Recorder.example

        recorder.record(invocation)

        detected = recorder.invoked?

        test "Detected" do
          assert(detected)
        end
      end

      context "Not Recorded" do
        recorder = RecordInvocation::Controls::Recorder.example

        detected = recorder.invoked?

        test "Not detected" do
          refute(detected)
        end
      end
    end
  end
end
