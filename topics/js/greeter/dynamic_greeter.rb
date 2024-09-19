class DynamicGreeter
  # is called, whenever a method is missing
  def method_missing(method_name, *arguments, &block)
    # method does not start with "greet_"
    return super unless method_name.to_s.start_with?("greet_")

    # extracts the name part from method_name
    name = method_name.to_s.split("_")[1]

    # define method that was missing
    self.class.send(:define_method, method_name) do |*args|
      "Hello, #{name.capitalize}! #{args.first || ''}"
    end

    # dynamically call the method we just defined
    send(method_name, *arguments)
  end
end

greeter = DynamicGreeter.new

puts greeter.foo

# dynamically define and call
puts greeter.greet_bob
# => "Hello, Bob! "

# dynamically define and call
puts greeter.greet_alice("How are you today?")
# => "Hello, Alice! How are you today?"

# just call
puts greeter.greet_alice("How are you today?")
# => "Hello, Alice! How are you today?"