# record_invocation

Record method invocations, query the invocations, and use predicates to verify a method's invocation

## Example

``` ruby
class SomeClass
  include RecordInvocation

  def some_method(some_parameter)
    record_invocation(binding)
  end

  record def some_recorded_method(some_parameter)
    :some_result
  end
end

recorder = SomeClass.new

recorder.some_method('some argument')

recorder.invoked?(:some_method)
# => true

recorder.invocation(:some_method)
# => <Invocation:0x.. 
 @method_name=:some_method, 
 @parameters={:some_parameter=>"some argument"}>

## Recorded method

recorder.some_recorded_method('some other argument')
# => :some_result

recorder.invoked?(:some_recorded_method)
# => true

recorder.invocation(:some_recorded_method)
# => <Invocation:0x..
 @method_name=:some_recorded_method,
 @parameters={:some_parameter=>"some other argument"}>
```

## Recording Invocations of an Object

In order to enable method invocations recording capabilities for an object, the `RecordInvocation` module needs to be included in the object's class.

``` ruby
class SomeClass
  include RecordInvocation
end
```

Invocations can be recorded by passing the current binding to the `record_invocation` method.

``` ruby
class SomeClass
  include RecordInvocation

  def some_method(some_parameter, some_other_parameter)
    record_invocation(binding)
  end
end

recorder = SomeClass.new

recorder.some_method('some argument', 'some other argument')

recorder.invocation(:some_method)
# => #<Invocation:0x...
 @method_name=:some_method,
 @parameters={:some_parameter=>"some argument", :some_other_parameter=>"some other argument"}>
```

An invocation can be retrieved based on its parameter values.

``` ruby
recorder.some_method('some argument', 'some other argument')

recorder.invocation(:some_method, some_parameter: 'some argument')
# => #<Invocation:0x...
 @method_name=:some_method,
 @parameters={:some_parameter=>"some argument", :some_other_parameter=>"some other argument"}>

recorder.invocation(:some_method, some_other_parameter: 'some other argument')
# => #<Invocation:0x...
 @method_name=:some_method,
 @parameters={:some_parameter=>"some argument", :some_other_parameter=>"some other argument"}>

recorder.invocation(:some_method, some_parameter: 'some argument', some_other_parameter: 'some other argument')
# => #<Invocation:0x...
 @method_name=:some_method,
 @parameters={:some_parameter=>"some argument", :some_other_parameter=>"some other argument"}>
```

If more than one invocation is found, only the first invocation will be returned.

If a method should have only been invoked once, the `one_invocation` method will raise an error rather than return the first invocation.

``` ruby
recorder.some_method('some argument', 'some other argument')
recorder.some_method('some argument', 'yet another argument')

recorder.one_invocation(:some_method)
# => More than one invocation record matches (Method Name: :some_method, Parameters: {}) (RecordInvocation::Error)

recorder.one_invocation(:some_method, some_parameter: 'some argument')
# => More than one invocation record matches (Method Name: :some_method, Parameters: {:some_parameter=>"some argument"}) (RecordInvocation::Error)
```

If only one invocation of the method was recorded, then that invocation will be returned, just as it does with the `invocation` method.

``` ruby
recorder.some_method('some argument', 'some other argument')

recorder.one_invocation(:some_method, some_parameter: 'some argument')
# => #<Invocation:0x...
 @method_name=:some_method,
 @parameters={:some_parameter=>"some argument", :some_other_parameter=>"some other argument"}>
```

If a method is invoked more than once, multiple invocation records can be retrieved.

``` ruby
recorder.some_method('some argument', 'some other argument')
recorder.some_method('another argument', 'yet another argument')

recorder.invocations(:some_method)
# => [#<Invocation:0x...
  @method_name=:some_method,
  @parameters={:some_parameter=>"some argument", :some_other_parameter=>"some other argument"}>,
 #<Invocation:0x...
  @method_name=:some_method,
  @parameters={:some_parameter=>"another argument", :some_other_parameter=>"yet another argument"}>]

recorder.invocations(:some_random_method)
# => []

recorder.invocations(:some_method, some_parameter: 'some argument')
# => [#<Invocation:0x...
  @method_name=:some_method,
  @parameters={:some_parameter=>"some argument", :some_other_parameter=>"some other argument"}>]

recorder.invocations(:some_method, some_other_parameter: 'some other argument')
# => [#<Invocation:0x...
  @method_name=:some_method,
  @parameters={:some_parameter=>"some argument", :some_other_parameter=>"some other argument"}>]

recorder.invocations(:some_method, some_parameter: 'some argument', some_other_parameter: 'some other argument')
# => [#<Invocation:0x...
  @method_name=:some_method,
  @parameters={:some_parameter=>"some argument", :some_other_parameter=>"some other argument"}>]
```

`RecordInvocation` provides predicates for detecting whether an invocation has been made.

``` ruby
recorder.some_method('some argument', 'some other argument')

recorder.invoked?(:some_method)
# => true

recorder.invoked?(:some_random_method)
# => false

recorder.invoked?(:some_method, some_parameter: 'some argument')
# => true

recorder.invoked?(:some_method, some_other_parameter: 'some other argument')
# => true

recorder.invoked?(:some_method, some_parameter: 'some argument', some_other_parameter: 'some other argument')
# => true
```

If a method should have only been invoked once, the `invoked_once?` predicate will raise an error if more than one matching invocation is detected.

``` ruby
recorder.some_method('some argument', 'some other argument')
recorder.some_method('some argument', 'yet another argument')

recorder.invoked_once?(:some_method)
# => More than one invocation record matches (Method Name: :some_method, Parameters: {}) (RecordInvocation::Error)

recorder.invoked_once?(:some_method, some_parameter: 'some argument')
# => More than one invocation record matches (Method Name: :some_method, Parameters: {:some_parameter=>"some argument"}) (RecordInvocation::Error)
```

If only one invocation of the method was recorded, then the predicate will respond affirmatively.

``` ruby
recorder.some_method('some argument', 'some other argument')

recorder.invoked_once?(:some_method, some_parameter: 'some argument')
# => true
```

The methods of the recorder may conflict with the methods implemented on the `RecordInvocation` module. If so, a secondary set of method names may be used to access the diagnostic functions provided by `RecordInvocation`:

- __invocation
- __invocations
- __invoked?
- __invoked_once?
