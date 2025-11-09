# -- Pipe operator --
# The pipe operator `|>` is used to pass the result of an expression as the
# first argument to the next function.  It helps in writing more readable and
# cleaner code by chaining function calls.

# Basic usage:
# Instead of creating a nested chain:
result = String.reverse(String.upcase(String.trim("  hello  ")))

result = "  hello  "
result = String.trim(result)
result = String.upcase(result)
result = String.reverse(result)


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

# -- Pipe operator with multiple arguments --
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


add = fn a, b -> a + b end



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

# -- More examples --

# Data transformation with lists:
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

result =
  numbers
  |> Enum.filter(&(&1 > 5))
  |> Enum.map(&(&1 * 2))
  |> Enum.sum()
# => 90


# Working with maps in a pipeline:
user_data = %{name: "john doe", age: 30, email: "JOHN@EXAMPLE.COM"}

formatted_user =
  user_data
  |> Map.update!(:name, &String.split(&1, " "))
  |> Map.update!(:name, fn parts -> Enum.map(parts, &String.capitalize/1) end)
  |> Map.update!(:name, &Enum.join(&1, " "))
  |> Map.update!(:email, &String.downcase/1)
  |> Map.put(:updated_at, DateTime.utc_now())
# => %{name: "John Doe", age: 30, email: "john@example.com", updated_at: ~U[...]}


# File processing pipeline:
# (This is a conceptual example)
"/path/to/file.txt"
|> File.read!()
|> String.split("\n")
|> Enum.filter(&(&1 != ""))
|> Enum.map(&String.trim/1)
|> Enum.take(10)


# JSON parsing and transformation:
json_string = ~s({"users": [{"name": "alice", "score": 95}, {"name": "bob", "score": 87}]})

top_scorer =
  json_string
  |> Jason.decode!()
  |> Map.get("users")
  |> Enum.max_by(& &1["score"])
  |> Map.get("name")
  |> String.upcase()
# Note: Requires Jason library
# => "ALICE"


# Using pipe with pattern matching:
data = {:ok, [1, 2, 3, 4, 5]}

result =
  data
  |> then(fn
    {:ok, list} -> list
    {:error, _} -> []
  end)
  |> Enum.sum()
# => 15


# Complex data processing pipeline:
orders = [
  %{id: 1, customer: "Alice", amount: 100, status: "completed"},
  %{id: 2, customer: "Bob", amount: 150, status: "pending"},
  %{id: 3, customer: "Alice", amount: 200, status: "completed"},
  %{id: 4, customer: "Charlie", amount: 75, status: "completed"}
]

total_completed_by_alice =
  orders
  |> Enum.filter(&(&1.status == "completed"))
  |> Enum.filter(&(&1.customer == "Alice"))
  |> Enum.map(& &1.amount)
  |> Enum.sum()
# => 300


# Using pipe with Enum.reduce:
sentence = "the quick brown fox jumps"

word_count_map =
  sentence
  |> String.split()
  |> Enum.reduce(%{}, fn word, acc ->
    Map.update(acc, word, 1, &(&1 + 1))
  end)
# => %{"brown" => 1, "fox" => 1, "jumps" => 1, "quick" => 1, "the" => 1}


# Pipe with comprehensions:
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

flattened_doubled =
  matrix
  |> List.flatten()
  |> Enum.map(&(&1 * 2))
# => [2, 4, 6, 8, 10, 12, 14, 16, 18]

# Alternative using comprehension:
flattened_doubled =
  for row <- matrix,
      num <- row do
    num * 2
  end
# => [2, 4, 6, 8, 10, 12, 14, 16, 18]


# Pipe with custom module functions:
defmodule StringHelpers do
  def remove_punctuation(string) do
    String.replace(string, ~r/[[:punct:]]/, "")
  end

  def count_words(string) do
    string
    |> String.split()
    |> length()
  end
end

text = "Hello, world! How are you?"

word_count =
  text
  |> StringHelpers.remove_punctuation()
  |> String.downcase()
  |> StringHelpers.count_words()
# => 5


# Using pipe with Stream for lazy evaluation:
# Stream is useful for large datasets or infinite sequences
result =
  1..1_000_000
  |> Stream.map(&(&1 * 2))
  |> Stream.filter(&(rem(&1, 3) == 0))
  |> Enum.take(10)
# => [6, 12, 18, 24, 30, 36, 42, 48, 54, 60]
