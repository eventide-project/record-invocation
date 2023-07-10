require_relative '../../automated_init'

context "Query" do
  context "Invocations" do
    context "No Arguments" do
      invocation = Controls::Invocation.example

      context "Recorded" do
        record_invocation = Controls::RecordInvocation.example

        record_invocation.record(invocation)
        record_invocation.record(invocation)

        retrieved_invocations = record_invocation.invocations

        test "All retrieved" do
          assert(retrieved_invocations == [invocation, invocation])
        end
      end

      context "Not Recorded" do
        record_invocation = Controls::RecordInvocation.example

        retrieved_invocations = record_invocation.invocations

        test "Not retrieved" do
          assert(retrieved_invocations.empty?)
        end
      end
    end
  end
end
