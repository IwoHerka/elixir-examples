# -- raise --
# The `raise` function is used to raise an exception.

raise "An error occurred!"
# => ** (RuntimeError) An error occurred!

# We can specify the type of exception to raise.

raise ArgumentError, "Invalid argument"
# => ** (ArgumentError) Invalid argument

# We can define custom exceptions:

defmodule CustomError do
  defexception message: "A custom error occurred"
end

raise CustomError, "An error occurred!"
# => ** (CustomError) An error occurred!

# -- Rescue --
# The `rescue` clause is used to catch exceptions that are raised during the
# execution of the `try` block.

try do
  # Code that may raise an exception
  raise "An error occurred!"
rescue
  e in RuntimeError ->  # Catch a specific exception
    IO.puts("Rescued from error: #{e.message}")
end
# => Rescued from error: An error occurred!

# You can also rescue from multiple types of exceptions:
try do
  raise "Another error!"
rescue
  e in RuntimeError ->
    IO.puts("Caught a RuntimeError: #{e.message}")
  e in ArgumentError ->
    IO.puts("Caught an ArgumentError: #{e.message}")
end

# -- Catch for non-local returns --
# The `catch` clause is used to catch non-exception values, such as thrown
# values.

try do
  throw :some_value  # This will throw a value
catch
  value -> IO.puts("Caught a thrown value: #{value}")
end
# => Caught a thrown value: some_value

# -- Using finally --
# Elixir does not have a `finally` block like some other languages, but you can
# use a `after` block to execute code after the `try` block.

try do
  IO.puts("Trying something...")
  raise "Oops!"
rescue
  e in RuntimeError ->
    IO.puts("Rescued from error: #{e.message}")
after
  IO.puts("This will always run, regardless of success or failure.")
end
# =>
# Trying something...
# Rescued from error: Oops!
# This will always run, regardless of success or failure.

# -- Limitations --
# - The `try` construct is not meant for flow control; it should only be used for handling exceptions.
# - You should avoid using `catch` for normal control flow, as it can lead to less readable code.
