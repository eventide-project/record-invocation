require_relative "../automated_init"

context "Actuator" do
  context "Multiple Methods" do
    object_class = Class.new do
      def some_method
      end

      def some_other_method
      end
    end

    object = object_class.new

    RecordInvocation.(object, :some_method, :some_other_method)

    object.some_method
    object.some_other_method

    context "Invocations" do
      recorded = object.invoked?(:some_method) &&
        object.invoked?(:some_other_method)

      detail "Records: #{object.records.pretty_inspect}"

      test "Recorded" do
        assert(recorded)
      end
    end
  end
end
