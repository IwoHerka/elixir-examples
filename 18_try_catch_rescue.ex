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

# -- Additional examples --

# -- Example 1: Catching exit signals --
# Exits are different from exceptions and throws. They can be caught using catch.

try do
  exit(:shutdown)  # Simulate a process exit
catch
  :exit, reason -> IO.puts("Caught an exit signal: #{reason}")
end
# => Caught an exit signal: shutdown

# -- Example 2: Catching multiple throw types --
# You can pattern match on different throw values in the catch block.

defmodule ThrowExample do
  def process(input) do
    try do
      case input do
        :error -> throw {:error, "Something went wrong"}
        :warning -> throw {:warning, "Be careful"}
        :info -> throw {:info, "Just FYI"}
        _ -> "Success"
      end
    catch
      {:error, msg} -> "ERROR: #{msg}"
      {:warning, msg} -> "WARNING: #{msg}"
      {:info, msg} -> "INFO: #{msg}"
    end
  end
end

IO.puts(ThrowExample.process(:error))    # => ERROR: Something went wrong
IO.puts(ThrowExample.process(:warning))  # => WARNING: Be careful
IO.puts(ThrowExample.process(:info))     # => INFO: Just FYI
IO.puts(ThrowExample.process(:ok))       # => Success

# -- Example 3: Combined rescue, catch, and after --
# You can use rescue for exceptions, catch for throws/exits, and after for cleanup.

defmodule CompleteExample do
  def risky_operation(type) do
    try do
      case type do
        :exception -> raise "Exception raised!"
        :throw -> throw "Thrown value!"
        :exit -> exit(:normal)
        _ -> IO.puts("Operation successful")
      end
    rescue
      e in RuntimeError ->
        IO.puts("Rescued exception: #{e.message}")
    catch
      :throw, value ->
        IO.puts("Caught throw: #{value}")
      :exit, reason ->
        IO.puts("Caught exit: #{reason}")
    after
      IO.puts("Cleanup completed")
    end
  end
end

CompleteExample.risky_operation(:exception)
# =>
# Rescued exception: Exception raised!
# Cleanup completed

CompleteExample.risky_operation(:throw)
# =>
# Caught throw: Thrown value!
# Cleanup completed

CompleteExample.risky_operation(:exit)
# =>
# Caught exit: normal
# Cleanup completed
