require_relative "../automated_init"

context "Actuator" do
  object_class = Class.new do
    def some_method
    end
  end

  object = object_class.new

  RecordInvocation.(object, :some_method)

  object.some_method

  context "Invocation" do
    recorded = object.invoked?(:some_method)

    detail "Records: #{object.records.pretty_inspect}"

    test "Recorded" do
      assert(recorded)
    end
  end
end
