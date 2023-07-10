require_relative '../../automated_init'

context "Queries" do
  context "Invocations" do
    context "By Method Name" do
      invocation = Controls::Invocation.example

      context "Recorded Multiple" do
        context "Matched Method Name" do
          record_invocation = Controls::Recorder.example

          record_invocation.record(invocation)
          record_invocation.record(invocation)

          retrieved_invocations = record_invocation.invocations(invocation.method_name)

          context "Retrieved" do
            assert(retrieved_invocations.length == 2)

            test "First" do
              assert(retrieved_invocations[0] == invocation)
            end

            test "Second" do
              assert(retrieved_invocations[1] == invocation)
            end
          end
        end

        context "Mismatched Method Name" do
          record_invocation = Controls::Recorder.example

          record_invocation.record(invocation)
          record_invocation.record(invocation)

          retrieved_invocations = record_invocation.invocations(SecureRandom.hex)

          test "Not retrieved" do
            assert(retrieved_invocations.empty?)
          end
        end
      end

      context "Not Recorded" do
        record_invocation = Controls::Recorder.example

        retrieved_invocations = record_invocation.invocations(invocation.method_name)

        test "Not retrieved" do
          assert(retrieved_invocations.empty?)
        end
      end
    end
  end
end
