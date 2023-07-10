require_relative '../../automated_init'

context "Queries" do
  context "One Invocation" do
    context "By Method Name" do
      invocation = Controls::Invocation.example

      context "Recorded" do
        context "Matched Method Name" do
          context "One Recorded" do
            record_invocation = Controls::Recorder.example

            record_invocation.record(invocation)

            retrieved_invocation = record_invocation.one_invocation(invocation.method_name)

            test "Detected" do
              assert(retrieved_invocation == invocation)
            end
          end

          context "Multiple Recorded" do
            record_invocation = Controls::Recorder.example

            record_invocation.record(invocation)
            record_invocation.record(invocation)

            test "Is an error" do
              assert_raises(RecordInvocation::Error) do
                record_invocation.one_invocation(invocation.method_name)
              end
            end
          end
        end

        context "Mismatched" do
          record_invocation = Controls::Recorder.example

          record_invocation.record(invocation)

          retrieved_invocation = record_invocation.one_invocation(SecureRandom.hex)

          test "Not retrieved" do
            assert(retrieved_invocation.nil?)
          end
        end
      end

      context "Not Recorded" do
        record_invocation = Controls::Recorder.example

        retrieved_invocation = record_invocation.one_invocation(SecureRandom.hex)

        test "Not retrieved" do
          assert(retrieved_invocation.nil?)
        end
      end
    end
  end
end
