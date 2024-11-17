# -- Loops in Elixir --
# Elixir does not have traditional loop constructs like `for` or `while` found
# in other languages.  Instead, it relies on recursion and higher-order
# functions to achieve looping behavior.

# -- Enum functions --
# The `Enum` module provides a variety of functions for working with
# collections.

# Apply a function to every element and return the result.
Enum.map([1, 2, 3], fn x -> x * 2 end)
# => [2, 4, 6]

# Apply a function, but ignore the result.
Enum.each([1, 2, 3], fn x -> x * 2 end)
# => :ok

# Apply a function and add the result to an accumulator.
Enum.reduce([1, 2, 3], 0, fn x, acc -> acc + x end)
# => 6

# Only keep the elements for which the function evaluates to truthy and filter out the rest.
Enum.filter([1, 2, 3], fn x -> x == 2 end)
# => [2]

# Reject/remove an element if the function evaluates to truthy.
Enum.reject([1, 2, 3], fn x -> x == 2 end)
# => [1, 3]

# -- for comprehension --
# The `for` construct can be used for list comprehensions, which allows you to
# generate lists based on existing collections.

list = [1, 2, 3, 4, 5]
list = 1..10
list = [a: 1, b: 2, c: 3]

# Example of using for comprehension to create a new list:
doubled = for x <- list, do: x * 2
# => [2, 4, 6, 8, 10]

# You can also filter elements using guards:
even_numbers = for x <- list, rem(x, 2) == 0, do: x * 5
# => [10, 20]

# You can iterate over a range ascending
result = for idx <- 1..10//1, do: idx
IO.inspect(result, label: "range - asc")

# Or descending. Note the step of -2.
# If you don't set the step, the loop will stop after the first element.
result = for idx <- 10..1//-2, do: idx
IO.inspect(result, label: "range - desc")

# You can iterate through a list of elements
result = for el <- ["Peter", 32, 190.47, :active], do: el
IO.inspect(result, label: "elements")

# Or you can have a nested for-loop
result = for x <- [1, 2], y <- [4, 5], do: {x, y}
IO.inspect(result, label: "nested")


# -- :into option --
# The `:into` option allows you to specify the type of collection you want to
# generate from the comprehension. By default, comprehensions generate lists,
# but you can use the `:into` option to generate other types of collections.

# Example of using the :into option to generate a map:
list = [{"a", 1}, {"b", 2}, {"c", 3}]
map = for {key, value} <- list, into: %{}, do: {key, value}
# => %{"a" => 1, "b" => 2, "c" => 3}

# Example of using the :into option to generate a binary:
chars = 'hello'
binary = for char <- chars, into: "", do: <<char>>
# => "hello"


# -- :reduce option --
# The `:reduce` option allows you to accumulate a value while iterating over the
# collection. It is similar to the `Enum.reduce/3` function.

# Example of using the :reduce option to calculate the sum of a list:
list = [1, 2, 3, 4, 5]
sum = for x <- list, reduce: 0 do
  acc -> acc + x
end
# => 15

# Example of using the :reduce option to build a string:
words = ["hello", "world"]
sentence = for word <- words, reduce: "" do
  acc -> acc <> word <> " "
end
# => "hello world "


# -- Recursion --
# Recursion is a fundamental concept in functional programming and is often used
# in Elixir to perform looping.

# Example of a simple recursive function to calculate the sum of a list:
defmodule Math do
  def sum([]), do: 0

  def sum([head | tail]), do: head + sum(tail)
end

# Usage:
total = Math.sum(list)
# => 15

# -- Fibonacci --
# Here are two different implementations of the Fibonacci sequence calculator:
# one using a for comprehension and another using recursion.

# Using recursion:
defmodule FibRecursive do
  def calculate(n) when n <= 1, do: n
  def calculate(n), do: calculate(n - 1) + calculate(n - 2)
end

# Using for comprehension:
defmodule FibFor do
  def calculate(n) when n <= 1, do: n

  def calculate(n) do
    fib = for _ <- 2..n,
      reduce: {0, 1} do
        {prev2, prev1} -> {prev1, prev1 + prev2}
    end

    elem(fib, 1)
  end
end

# Note: The recursive version, while more straightforward to understand,
# has exponential time complexity O(2^n). The for comprehension version
# is more efficient with linear time complexity O(n).

defmodule Factorial do
  def calculate(0), do: 1
  def calculate(n) when n > 0, do: n * calculate(n - 1)
end


# -- Tail recursion --
# Elixir optimizes tail-recursive functions to avoid stack overflow errors.
# A tail-recursive function is one where the recursive call is the last operation in the function.

defmodule Factorial do
  def calculate(n), do: calculate(n, 1)

  defp calculate(0, acc), do: acc
  defp calculate(n, acc), do: calculate(n - 1, n * acc)
end

# Usage:
fact = Factorial.calculate(5)
# => 120
