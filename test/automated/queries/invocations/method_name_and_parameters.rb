require_relative '../../automated_init'

context "Queries" do
  context "Invocations" do
    context "By Method Name and Parameters" do
      invocation = Controls::Invocation.example
      ## Not used - Antoine, Sun Jul 9 2023
      # other_invocation = Controls::Invocation.other_example

      context "Recorded Multiple" do
        context "Matched Parameters" do
          context "One Parameter Match" do
            record_invocation = Controls::Recorder.example

            record_invocation.record(invocation)
            record_invocation.record(invocation)

            method_name = invocation.method_name
            parameters = { some_parameter: 1 }

            retrieved_invocations = record_invocation.invocations(method_name, **parameters)

            context "Retrieved" do
              assert(retrieved_invocations.length == 2)

              test "First" do
                assert(retrieved_invocations[0] == invocation)
              end

              test "Second" do
                assert(retrieved_invocations[1] == invocation)
              end
            end
          end

          context "Multiple Parameters Match" do
            record_invocation = Controls::Recorder.example

            record_invocation.record(invocation)
            record_invocation.record(invocation)

            method_name = invocation.method_name
            parameters = { some_parameter: 1, some_other_parameter: 11 }

            retrieved_invocations = record_invocation.invocations(method_name, **parameters)

            context "Retrieved" do
              assert(retrieved_invocations.length == 2)

              test "First" do
                assert(retrieved_invocations[0] == invocation)
              end

              test "Second" do
                assert(retrieved_invocations[1] == invocation)
              end
            end
          end
        end

        context "Mismatched Parameters" do
          record_invocation = Controls::Recorder.example

          record_invocation.record(invocation)
          record_invocation.record(invocation)

          method_name = invocation.method_name
          parameters = { some_parameter: SecureRandom.hex }

          retrieved_invocations = record_invocation.invocations(method_name, **parameters)

          test "Not Retrieved" do
            assert(retrieved_invocations.empty?)
          end
        end
      end

      context "None Recorded" do
        record_invocation = Controls::Recorder.example

        method_name = invocation.method_name
        parameters = { some_parameter: 1 }

        retrieved_invocations = record_invocation.invocations(method_name, **parameters)

        test "Not retrieved" do
          assert(retrieved_invocations.empty?)
        end
      end
    end
  end
end
