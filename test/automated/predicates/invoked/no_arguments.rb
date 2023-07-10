require_relative '../../automated_init'

context "Predicates" do
  context "Invoked" do
    context "No Arguments" do
      invocation = Controls::Invocation.example

      context "Recorded" do
        record_invocation = Controls::RecordInvocation.example

        record_invocation.record(invocation)

        detected = record_invocation.invoked?

        test "Detected" do
          assert(detected)
        end
      end

      context "Not Recorded" do
        record_invocation = Controls::RecordInvocation.example

        detected = record_invocation.invoked?

        test "Not detected" do
          refute(detected)
        end
      end
    end
  end
end
