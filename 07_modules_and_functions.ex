# -- Modules --
# Modules are used to group related functions together. They are defined using
# the `defmodule` keyword:
defmodule Math do

  # -- Module Attributes --
  # Module attributes are constants (immutable) that can be used within the module.
  # They are private, meaning that they cannot be accessed from outside the module.
  @pi 3.14159


  # -- Functions --
  # Functions are defined using the `def` keyword.
  def add(a, b) do
    a + b
  end


  def add2(x, y) do
    # Within the same module, we can call functions only by their name:
    add(x, y)

    # Functions from other modules require they full name:
    OtherModule.subtract(x, y)
  end


  # -- Guards --
  # Guards are additional conditions that can be used in function definitions.
  # Only specific functions can be used in guards. Generally all functions in
  # Kernel module are supported.
  def is_even(n) when is_integer(n) and rem(n, 2) == 0 do
    true
  end

  def is_even(_n), do: false


  # -- Default Arguments --
  # Functions can have default arguments.
  def multiply(a, b \\ 1) do
    a * b
  end


  # -- Function Arity --
  # Function arity refers to the number of arguments a function takes.
  # The same function name can be used with different arities.
  def greet(name) do
    "Hello, #{name}!"
  end

  def greet(name, title) do
    "Hello, #{title} #{name}!"
  end

  # Technically, those two are completely separate functions:
  # Math.greet/1 and Math.greet/2.


  # -- Return values --
  # Functions in Elixir always return the value of the last expression.
  # However, other expressions are still evaluated, which means they can be
  # called for side effects:
  def circle_area(radius) do
    ignored = "This value is not returned"

    drop_database() # This will be evaluated!

    @pi * radius * radius
  end
end
