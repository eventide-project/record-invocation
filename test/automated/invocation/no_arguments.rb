require_relative '../automated_init'

context "Invocation" do
  context "No Arguments" do
    invocation = RecordInvocation::Controls::Invocation::NoParameters.example

    test "No arguments are recorded" do
      assert(invocation.arguments.empty?)
    end
  end
end
