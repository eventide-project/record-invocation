require_relative '../../automated_init'

context "Queries" do
  context "Invocation" do
    context "Multiple Detected" do
      invocation = RecordInvocation::Controls::Invocation.example

      context "Strict" do
        context "By Method Name" do
          recorder = RecordInvocation::Controls::Recorder.example

          recorder.record(invocation)
          recorder.record(invocation)

          test "Is an error" do
            assert_raises(RecordInvocation::Error) do
              recorder.invocation(invocation.method_name, once: true)
            end
          end
        end

        context "By Parameters" do
          recorder = RecordInvocation::Controls::Recorder.example

          recorder.record(invocation)
          recorder.record(invocation)

          test "Is an error" do
            assert_raises(RecordInvocation::Error) do
              recorder.invocation(invocation.method_name, some_parameter: 1, once: true)
            end
          end
        end
      end
    end
  end
end
