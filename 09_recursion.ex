# -- Recursion in Elixir --

# Key concepts:
# - Base case: A condition that stops the recursion. Without it, the function
#   would call itself indefinitely.
# - Recursive step: The part of the function where it calls itself, usually
#   with arguments that move closer to the base case.
# - Pattern matching: Elixir often uses pattern matching in function heads to
#   define both the base cases and the recursive steps elegantly.

# -- Factorial --

defmodule Recursion do
  # 1. Factorial

  def factorial(0), do: 1

  def factorial(n) when n > 0 do
    n * factorial(n - 1)
  end

  # 2. Summing elements in a list

  def sum_list([]), do: 0

  def sum_list([head | tail]) do
    head + sum_list(tail)
  end

  # 3. Reversing a list

  def reverse_list(list) do
    do_reverse(list, [])
  end

  defp do_reverse([], accumulator) do
    accumulator
  end

  defp do_reverse([head | tail], accumulator) do
    do_reverse(tail, [head | accumulator])
  end

  # 4. Repeating an action

  def print_multiple_times(msg, n) when n > 0 do
    IO.puts(msg)
    print_multiple_times(msg, n - 1)
  end

  def print_multiple_times(_msg, 0) do
    :ok
  end

  # 5. Transforming elements in a list

  def double_each([head | tail]) do
    [head * 2 | double_each(tail)]
  end

  def double_each([]) do
    []
  end
end
