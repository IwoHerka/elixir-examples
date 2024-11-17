# -- Protocols in Elixir --
# Protocols in Elixir provide a way to achieve polymorphism, allowing different
# data types to implement the same set of functions.  This enables you to write
# generic code that can work with any data type that implements a specific
# protocol.

# -- Defining a Protocol --
# You define a protocol using the `defprotocol` macro. Inside the protocol, you
# specify the functions that must be implemented.

defprotocol Shape do
  @doc "Calculates the area of the shape."
  def area(shape)

  @doc "Calculates the perimeter of the shape."
  def perimeter(shape)
end

# -- Implementing a protocol --
# To implement a protocol for a specific data type, you use the `defimpl` macro.
# You can implement the protocol for multiple data types.

defimpl Shape, for: Rectangle do
  def area(%Rectangle{width: width, height: height}) do
    width * height
  end

  def perimeter(%Rectangle{width: width, height: height}) do
    2 * (width + height)
  end
end

defimpl Shape, for: Circle do
  def area(%Circle{radius: radius}) do
    :math.pi() * radius * radius
  end

  def perimeter(%Circle{radius: radius}) do
    2 * :math.pi() * radius
  end
end

# -- Using protocols --
# Once you have defined a protocol and implemented it for specific data types, you can use it to call the functions defined in the protocol.

defmodule Rectangle do
  defstruct width: 0, height: 0
end

defmodule Circle do
  defstruct radius: 0
end

# Example usage:
rectangle = %Rectangle{width: 5, height: 10}
circle = %Circle{radius: 3}

# Calling the protocol functions:
IO.puts("Rectangle Area: #{Shape.area(rectangle)}")   # => Rectangle Area: 50
IO.puts("Rectangle Perimeter: #{Shape.perimeter(rectangle)}") # => Rectangle Perimeter: 30

IO.puts("Circle Area: #{Shape.area(circle)}")         # => Circle Area: 28.274333882308138
IO.puts("Circle Perimeter: #{Shape.perimeter(circle)}") # => Circle Perimeter: 18.84955592153876

# -- Protocols and polymorphism --
# The power of protocols lies in their ability to allow different data types to
# be treated uniformly.  You can write functions that accept any type that
# implements a specific protocol.

def print_shape_info(shape) do
  IO.puts("Area: #{Shape.area(shape)}")
  IO.puts("Perimeter: #{Shape.perimeter(shape)}")
end

# Example usage:
print_shape_info(rectangle)
# => Area: 50
# => Perimeter: 30

print_shape_info(circle)
# => Area: 28.274333882308138
# => Perimeter: 18.84955592153876

# -- Limitations --
# - Protocols cannot be implemented for built-in types (like integers or strings).
# - Protocols are not as flexible as type classes in some other languages, as they require explicit implementations.


# -- Built-in Elixir protocols --
# Elixir comes with several built-in protocols that provide common functionality
# for different data types. Here are some of the most commonly used built-in protocols:

# 1. Enumerable
# The Enumerable protocol is used to traverse data structures. It is implemented
# for data types like lists, maps, ranges, and more. It provides functions like
# `count/1`, `member?/2`, and `reduce/3`.

# 2. Collectable
# The Collectable protocol is used to insert elements into a data structure. It
# is implemented for data types like lists, maps, and more. It provides the
# `into/1` function, which is used by functions like `Enum.into/2`.

# 3. Inspect
# The Inspect protocol is used to convert data structures into a human-readable
# format. It is implemented for most data types and is used by the `IO.inspect/2`
# function to print data structures.

# 4. String.Chars
# The String.Chars protocol is used to convert data structures into strings. It
# is implemented for data types like integers, floats, atoms, and more. It
# provides the `to_string/1` function, which is used by the `Kernel.to_string/1`
# function.

# 5. List.Chars
# The List.Chars protocol is used to convert data structures into charlists. It
# is implemented for data types like integers, floats, atoms, and more. It
# provides the `to_charlist/1` function, which is used by the `Kernel.to_charlist/1`
# function.

# 6. IEx.Info
# The IEx.Info protocol is used to provide information about data structures in
# the IEx shell. It is implemented for most data types and is used by the `i/1`
# function in IEx to display information about a value.

# These built-in protocols provide a foundation for working with different data
# types in a consistent and flexible manner. They enable polymorphism and allow
# developers to extend the behavior of existing data types by implementing
# these protocols.


# -- Example --
# Example of implementing String.Chars protocol for a custom struct

defmodule Person do
  defstruct name: "", age: 0
end

defimpl String.Chars, for: Person do
  def to_string(%Person{name: name, age: age}) do
    "Name: #{name}, Age: #{age}"
  end
end

# Usage:
person = %Person{name: "Alice", age: 30}
IO.puts(person)
# => Name: Alice, Age: 30
