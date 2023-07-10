require_relative '../../automated_init'

context "Queries" do
  context "Invocation" do
    context "By Method Name" do
      invocation = Controls::Invocation.example

      context "Recorded One" do
        context "Matched Method Name" do
          record_invocation = Controls::RecordInvocation.example

          record_invocation.record(invocation)

          retrieved_invocation = record_invocation.invocation(invocation.method_name)

          context "Retrieved" do
            assert(retrieved_invocation == invocation)
          end
        end

        context "Mismatched Method Name" do
          record_invocation = Controls::RecordInvocation.example

          record_invocation.record(invocation)

          retrieved_invocation = record_invocation.invocation(SecureRandom.hex)

          context "Not retrieved" do
            assert(retrieved_invocation.nil?)
          end
        end
      end

      context "Recorded Multiple" do
        other_invocation = Controls::Invocation.example

        context "Matched Method Name" do
          record_invocation = Controls::RecordInvocation.example

          record_invocation.record(invocation)
          record_invocation.record(other_invocation)

          retrieved_invocation = record_invocation.invocation(invocation.method_name)

          context "Retrieved First" do
            assert(retrieved_invocation == invocation)
          end
        end
      end

      context "Not Recorded" do
        record_invocation = Controls::RecordInvocation.example

        retrieved_invocation = record_invocation.invocation(SecureRandom.hex)

        test "Not retrieved" do
          assert(retrieved_invocation.nil?)
        end
      end
    end
  end
end
