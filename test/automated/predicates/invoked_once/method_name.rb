require_relative '../../automated_init'

context "Predicate" do
  context "Invoked Once" do
    context "By Method Name" do
      invocation = Controls::Invocation.example

      context "Recorded" do
        context "Matched Method Name" do
          context "One Recorded" do
            record_invocation = Controls::Recorder.example

            record_invocation.record(invocation)

            detected = record_invocation.invoked_once?(invocation.method_name)

            test "Detected" do
              assert(detected)
            end
          end

          context "Multiple Recorded" do
            record_invocation = Controls::Recorder.example

            record_invocation.record(invocation)
            record_invocation.record(invocation)

            test "Is an error" do
              assert_raises(RecordInvocation::Error) do
                record_invocation.invoked_once?(invocation.method_name)
              end
            end
          end
        end

        context "Mismatched" do
          record_invocation = Controls::Recorder.example

          record_invocation.record(invocation)

          detected = record_invocation.invoked_once?(SecureRandom.hex)

          test "Not detected" do
            refute(detected)
          end
        end
      end

      context "Not Recorded" do
        record_invocation = Controls::Recorder.example

        detected = record_invocation.invoked_once?(invocation.method_name)

        test "Not detected" do
          refute(detected)
        end
      end
    end
  end
end
