# -- Pipe operator --
# The pipe operator `|>` is used to pass the result of an expression as the
# first argument to the next function.  It helps in writing more readable and
# cleaner code by chaining function calls.

# Basic usage:
# Instead of creatign a nested chain:
result = String.reverse(String.upcase(String.trim("  hello  ")))

# You can use the pipe operator:
result =
  "  hello  "
  |> String.trim()
  |> String.upcase()
  |> String.reverse()
# => "OLLEH"

# -- Using with anonymous functions --
# We can also use the pipe operator with anonymous functions, but we need to use
# parentheses.

add = fn a, b -> a + b end

result =
  1
  |> add.(2)
  |> add.(3)

# The result will be 6.

# -- Pipe operator with wultiple arguments --
# When the function you are piping into takes multiple arguments, you can use
# the pipe operator to pass the first argument, and provide the rest manually:

defmodule Math do
  def multiply(a, b), do: a * b
end

result =
  5
  |> Math.multiply(2)
  |> Math.multiply(3)
# => 30


# -- Limitations --
# The pipe operator only works when the function you are piping into expects the
# piped value as its first argument.  If the function expects the value in a
# different position, you will need to use an anonymous function or rearrange
# the arguments.

# Example of rearranging arguments:
defmodule Math do
  def subtract(a, b), do: a - b
end

result =
  10
  |> (&Math.subtract(5, &1)).()
# => 5

# -- then/2 --
# The `then` macro can be used to chain operations in a similar way to the pipe
# operator. It is particularly useful when we want to perform operations that
# do not fit well with the pipe operator.

result =
  "  hello  "
  |> String.trim()
  |> String.upcase()
  |> then(&String.reverse/1)
  |> then(fn x ->
    IO.puts("Result: #{x}")
    x
  end)
# => "OLLEH"

# -- tap/2 --
# The `tap` macro allows to perform side effects in the middle of a pipeline
# without affecting the result. This is useful for logging, debugging, or other
# side effects.

result =
  "  hello  "
  |> String.trim()
  |> tap(&IO.puts("After trim: #{&1}"))
  |> String.upcase()
  |> tap(&IO.puts("After upcase: #{&1}"))
  |> String.reverse()
  |> tap(&IO.puts("After reverse: #{&1}"))
# => "OLLEH"

# -- Debugging with dbg or IO.inspect/1 --
# The `dbg` macro is a powerful tool for debugging pipelines. It prints the
# value of the expression and its result.  The `inspect` function can also be
# used for debugging, but it is less powerful than `dbg`.

require Logger

list = [1, 2, 3, 4, 5]

dbg(list)
# =>
# [hello_world.ex:10: (file)]
# list #=> [1, 2, 3, 4, 5]

dbg()

# When used on pipeline, dbg will print value of each transformation:
result =
  "  hello  "
  |> String.trim()
  |> String.upcase()
  |> String.reverse()
  |> dbg()
# =>
# [iex:16: (file)]
# "  hello  " #=> "  hello  "
# |> String.trim() #=> "hello"
# |> String.upcase() #=> "HELLO"
# |> String.reverse() #=> "OLLEH"
# => "OLLEH"


result =
  "  hello  "
  |> String.trim()
  |> IO.inspect(label: "After trim")
  |> String.upcase()
  |> IO.inspect(label: "After upcase")
  |> String.reverse()
  |> IO.inspect(label: "After reverse")
# => "OLLEH"
