require_relative '../test_init'
require_relative '../../lib/patterns/service'

ExampleService = Class.new(Patterns::Service) do
  attr_reader :arg_one, :arg_two

  def initialize(arg_one:, arg_two:)
    @arg_one = arg_one
    @arg_two = arg_two
  end

  def call
    fail! :something_wrong if arg_one == :fail
    @result = arg_two
  end
end

context "When service would fail " do
  subject = ExampleService.call(arg_one: :fail, arg_two: 'two')

  test "it provides error" do
    assert(subject.error == :something_wrong)
  end

  test "it does not provide result" do
    assert(subject.result.nil?)
  end
end

context "when service would succeed" do
  subject = ExampleService.call(arg_one: "one", arg_two: 'two')
  test "it does not provide result" do
    assert(subject.result == 'two')
  end
end

test "returns a service instance" do
  subject = ExampleService.call(arg_one: "one", arg_two: 'two')
  assert(subject.is_a?(ExampleService))
end


test 'instantiates service object passing keyword arguments to constructor' do
  assert_raises(ArgumentError) { ExampleService.call }

  refute_raises do
    ExampleService.call(arg_one: 10, arg_two: 20)
  end
end


test 'service object will only handle keyword arguments - double splat operator in Patterns::Service' do
  AnotherService = Class.new(Patterns::Service) do
    def initialize(arg1, arg2); end
    def call; end
  end

  assert_raises(ArgumentError) { AnotherService.call }
  assert_raises(ArgumentError) { AnotherService.call(10, 20) }
end


test 'calling #call on class, will call #call on instance' do
  SimpleService = Class.new(Patterns::Service) do
    def call
      @result = "I have been called"
    end
  end

  test do
    assert(SimpleService.call.result == "I have been called")
  end
end
