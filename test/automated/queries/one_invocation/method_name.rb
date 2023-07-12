require_relative '../../automated_init'

context "Queries" do
  context "One Invocation" do
    context "By Method Name" do
      invocation = RecordInvocation::Controls::Invocation.example

      context "Recorded" do
        context "Matched Method Name" do
          context "One Recorded" do
            recorder = RecordInvocation::Controls::Recorder.example

            recorder.record(invocation)

            retrieved_invocation = recorder.one_invocation(invocation.method_name)

            test "Detected" do
              assert(retrieved_invocation == invocation)
            end
          end

          context "Multiple Recorded" do
            recorder = RecordInvocation::Controls::Recorder.example

            recorder.record(invocation)
            recorder.record(invocation)

            test "Is an error" do
              assert_raises(RecordInvocation::Error) do
                recorder.one_invocation(invocation.method_name)
              end
            end
          end
        end

        context "Mismatched" do
          recorder = RecordInvocation::Controls::Recorder.example

          recorder.record(invocation)

          retrieved_invocation = recorder.one_invocation(SecureRandom.hex)

          test "Not retrieved" do
            assert(retrieved_invocation.nil?)
          end
        end
      end

      context "Not Recorded" do
        recorder = RecordInvocation::Controls::Recorder.example

        retrieved_invocation = recorder.one_invocation(SecureRandom.hex)

        test "Not retrieved" do
          assert(retrieved_invocation.nil?)
        end
      end
    end
  end
end
