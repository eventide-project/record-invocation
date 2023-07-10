require_relative '../../automated_init'

context "Queries" do
  context "Invocation" do
    context "By Method Name and Parameters" do
      invocation = Controls::Invocation.example

      context "Recorded One" do
        context "Matched Parameters" do
          context "One Parameter Match" do
            record_invocation = Controls::Recorder.example

            record_invocation.record(invocation)

            method_name = invocation.method_name
            parameters = { some_parameter: 1 }

            retrieved_invocation = record_invocation.invocation(method_name, **parameters)

            context "Retrieved" do
              assert(retrieved_invocation == invocation)
            end
          end

          context "Multiple Parameters Match" do
            record_invocation = Controls::Recorder.example

            record_invocation.record(invocation)

            method_name = invocation.method_name
            parameters = { some_parameter: 1, some_other_parameter: 11 }

            retrieved_invocation = record_invocation.invocation(method_name, **parameters)

            test "Retrieved" do
              assert(retrieved_invocation == invocation)
            end
          end
        end
      end

      context "Recorded Multiple" do
        other_invocation = Controls::Invocation.example

        context "Matched Parameters" do
          context "One Parameter Match" do
            record_invocation = Controls::Recorder.example

            record_invocation.record(invocation)
            record_invocation.record(other_invocation)

            method_name = invocation.method_name
            parameters = { some_parameter: 1 }

            retrieved_invocation = record_invocation.invocation(method_name, **parameters)

            context "Retrieved First" do
              assert(retrieved_invocation == invocation)
            end
          end

          context "Multiple Parameters Match" do
            record_invocation = Controls::Recorder.example

            record_invocation.record(invocation)
            record_invocation.record(other_invocation)

            method_name = invocation.method_name
            parameters = { some_parameter: 1, some_other_parameter: 11 }

            retrieved_invocation = record_invocation.invocation(method_name, **parameters)

            test "Retrieved First" do
              assert(retrieved_invocation == invocation)
            end
          end
        end
      end

      context "Recorded" do
        context "No Parameters Match" do
          record_invocation = Controls::Recorder.example

          record_invocation.record(invocation)

          method_name = invocation.method_name
          parameters = { some_parameter: SecureRandom.hex }

          retrieved_invocation = record_invocation.invocation(method_name, **parameters)

          context "Not Retrieved" do
            assert(retrieved_invocation.nil?)
          end
        end
      end

      context "Not Recorded" do
        record_invocation = Controls::Recorder.example

        method_name = invocation.method_name
        parameters = { some_parameter: 1 }

        retrieved_invocation = record_invocation.invocation(method_name, **parameters)

        context "Not Retrieved" do
          assert(retrieved_invocation.nil?)
        end
      end
    end
  end
end
