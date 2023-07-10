require_relative '../../automated_init'

context "Predicates" do
  context "Invoked" do
    context "Multiple Detected" do
      invocation = Controls::Invocation.example

      context "Strict" do
        context "By Method Name" do
          record_invocation = Controls::Recorder.example

          record_invocation.record(invocation)
          record_invocation.record(invocation)

          test "Is an error" do
            assert_raises(RecordInvocation::Error) do
              record_invocation.invoked?(invocation.method_name, strict: true)
            end
          end
        end

        context "By Parameters" do
          record_invocation = Controls::Recorder.example

          record_invocation.record(invocation)
          record_invocation.record(invocation)

          test "Is an error" do
            assert_raises(RecordInvocation::Error) do
              record_invocation.invoked?(invocation.method_name, some_parameter: 1, strict: true)
            end
          end
        end
      end
    end
  end
end
