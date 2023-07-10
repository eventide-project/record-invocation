require_relative '../../automated_init'

context "Predicates" do
  context "Invoked" do
    context "By Method Name" do
      invocation = Controls::Invocation.example

      context "Recorded" do
        context "Matched Method Name" do
          record_invocation = Controls::Recorder.example

          record_invocation.record(invocation)

          detected = record_invocation.invoked?(invocation.method_name)

          test "Detected" do
            assert(detected)
          end
        end

        context "Mismatched Method Name" do
          record_invocation = Controls::Recorder.example

          record_invocation.record(invocation)

          detected = record_invocation.invoked?(SecureRandom.hex)

          test "Not detected" do
            refute(detected)
          end
        end
      end

      context "Not Recorded" do
        record_invocation = Controls::Recorder.example

        detected = record_invocation.invoked?(invocation.method_name)

        test "Not detected" do
          refute(detected)
        end
      end
    end
  end
end
