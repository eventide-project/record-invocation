require_relative 'automated_init'

context "Record Invocation" do
  record_invocation = Controls::RecordInvocation.example

  invocation = Controls::Invocation.example

  record_invocation.record(invocation)

  context "Invocation" do
    test "Included in list of recorded invocations" do
      assert(record_invocation.records.include?(invocation))
    end
  end
end
