module RecordInvocation
  Error = ::Class.new(RuntimeError)

  def self.included(cls)
    cls.class_exec do
      extend Recorded
    end
  end

  def __records
    @__records ||= []
  end
  alias :records :__records

  def __record(invocation)
    __records << invocation
    records
  end
  alias :record :__record

  def __record_invocation(invocation_or_binding)
    if invocation_or_binding.is_a?(Binding)
      invocation = Invocation.build(invocation_or_binding)
    end

    __record(invocation)
    invocation
  end
  alias :record_invocation :__record_invocation

  def __invocation(method_name, **parameters)
    strict = parameters.delete(:strict)
    strict ||= false

    invocations = __invocations(method_name, **parameters)

    if invocations.empty?
      return nil
    end

    if strict && invocations.length > 1
      raise Error, "More than one invocation record matches (Method Name: #{method_name.inspect}, Parameters: #{parameters.inspect})"
    end

    invocations.first
  end
  alias :invocation :__invocation

  def __one_invocation(method_name, **parameters)
    parameters[:strict] = true
    __invocation(method_name, **parameters)
  end
  alias :one_invocation :__one_invocation

  def __invocations(method_name=nil, **parameters)
    if method_name.nil? && parameters.empty?
      return __records
    end

    invocations = __records.select { |invocation| invocation.method_name == method_name }

    if parameters.nil?
      return invocations
    end

    if invocations.empty?
      return []
    end

    invocations = invocations.select do |invocation|
      parameters.all? do |match_parameter_name, match_parameter_value|
        invocation_value = invocation.parameters[match_parameter_name]

        invocation_value == match_parameter_value
      end
    end

    invocations
  end
  alias :invocations :__invocations

  def __invoked?(method_name=nil, **parameters)
    if method_name.nil? && parameters.empty?
      return !__records.empty?
    end

    if not parameters.key?(:strict)
      parameters[:strict] = false
    end

    invocation = __invocation(method_name, **parameters)
    !invocation.nil?
  end
  alias :invoked? :__invoked?

  def __invoked_once?(method_name, **parameters)
    parameters[:strict] = true
    __invoked?(method_name, **parameters)
  end
  alias :invoked_once? :__invoked_once?

  module Recorded
    def recorded_macro(method_name, &implementation)

      define_method(method_name) do |*args, **kwargs|
        record_invocation(binding)
        implementation.call(*args, **kwargs)
      end
    end
    alias :recorded :recorded_macro
  end
end
