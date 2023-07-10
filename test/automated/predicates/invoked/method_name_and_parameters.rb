require_relative '../../automated_init'

context "Predicates" do
  context "Invoked" do
    context "By Method Name and Parameters" do
      invocation = Controls::Invocation.example

      context "Recorded" do
        context "Matched Parameters" do
          context "One Parameter Match" do
            record_invocation = Controls::RecordInvocation.example

            record_invocation.record(invocation)

            method_name = invocation.method_name
            parameters = { some_parameter: 1 }

            detected = record_invocation.invoked?(method_name, **parameters)

            detail "Match Method Name: #{method_name.inspect}"
            detail "Match Parameters: #{parameters.inspect}"
            detail "Recorded Invocations: #{record_invocation.records.inspect}"

            test "Detected" do
              assert(detected)
            end
          end

          context "Multiple Parameters Match" do
            record_invocation = Controls::RecordInvocation.example

            record_invocation.record(invocation)

            method_name = invocation.method_name
            parameters = { some_parameter: 1, some_other_parameter: 11 }

            detected = record_invocation.invoked?(method_name, **parameters)

            detail "Match Method Name: #{method_name.inspect}"
            detail "Match Parameters: #{parameters.inspect}"
            detail "Recorded Invocations: #{record_invocation.records.inspect}"

            test "Detected" do
              assert(detected)
            end
          end
        end

        context "Mismatched Parameters" do
          record_invocation = Controls::RecordInvocation.example

          record_invocation.record(invocation)

          method_name = invocation.method_name
          parameters = { some_parameter: SecureRandom.hex }

          detected = record_invocation.invoked?(method_name, **parameters)

          detail "Match Method Name: #{method_name.inspect}"
          detail "Match Parameters: #{parameters.inspect}"
          detail "Recorded Invocations: #{record_invocation.records.inspect}"

          test "Not detected" do
            refute(detected)
          end
        end
      end

      context "Not Recorded" do
        record_invocation = Controls::RecordInvocation.example

        method_name = invocation.method_name
        parameters = { some_parameter: 1 }

        detected = record_invocation.invoked?(method_name, **parameters)

        test "Not detected" do
          refute(detected)
        end
      end
    end
  end
end
