require_relative "../../automated_init"

context "Predicate" do
  context "Invoked Once" do
    context "By Method Name" do
      invocation = RecordInvocation::Controls::Invocation.example

      context "Recorded" do
        context "Matched Method Name" do
          context "One Recorded" do
            recorder = RecordInvocation::Controls::Recorder.example

            recorder.record(invocation)

            detected = recorder.invoked_once?(invocation.method_name)

            test "Detected" do
              assert(detected)
            end
          end

          context "Multiple Recorded" do
            recorder = RecordInvocation::Controls::Recorder.example

            recorder.record(invocation)
            recorder.record(invocation)

            test "Is an error" do
              assert_raises(RecordInvocation::Error) do
                recorder.invoked_once?(invocation.method_name)
              end
            end
          end
        end

        context "Mismatched" do
          recorder = RecordInvocation::Controls::Recorder.example

          recorder.record(invocation)

          detected = recorder.invoked_once?(SecureRandom.hex)

          test "Not detected" do
            refute(detected)
          end
        end
      end

      context "Not Recorded" do
        recorder = RecordInvocation::Controls::Recorder.example

        detected = recorder.invoked_once?(invocation.method_name)

        test "Not detected" do
          refute(detected)
        end
      end
    end
  end
end
