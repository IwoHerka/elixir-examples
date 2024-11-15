# Pattern matching is a feature in Elixir that allows to match values against a
# pattern, and deducting new definitions from it's structure.
# It is often used to deconstruct data structures, such as lists, maps, and tuples.

# General syntax:
# expression = pattern

x = 1
# Match 'structure' of 1 to unknown variable 'x'.
# This effectively results in 'x' being deducted to must be equal to 1.


# Pattern on the right must be fully known:
1 = x
# This words because 'x' is known.

2 = x
# MatchError, 2 != 1

1 = unknown
# MatchError, 'unknown' is undefined


# Using PM, we can destructure any data structure with the same syntax used to
# construct it.


# Lists have to be matched fully:
[x, y] = [1, 2]


# Matches the head of the list (1) to 'head' and
# the tail of the list to 'tail' ([2, 3])
[head | tail] = [1, 2, 3]


# This is based on list construction syntax:
list = [head | tail]
# which adds 'head' value to the front of 'tail' list.


# Tuples have to be matched fully:
# _ can be used as a wildcard to ignore a value
{a, _, b} = {1, 2, 3}


# Tuples are often matched as return values:
fun = fn -> {:ok, 59178407} end

{:ok, value} = fun.()

{:error, reasone} = fun.()
# MatchError


# Keyword lists have to be matched fully:
[a: a, b: _b, c: c] = [a: 1, b: 2, c: 3]


# Maps can be matched partially:
%{age: age} = %{name: "John", age: 30}


# The pin operator ^ allows to match against the value of an existing variable:
x = 1

^x = 1
# This is equivalent to '1 = 1'

^x = 2
# This is equivalent to '1 = 2',
# which will result in a MatchError.

# Pin can be used in any pattern match expression:
c = 7

{a, b, ^c} = {1, 2, 3}
# MatchError, 3 != 7


# Strings can be matched too:
"Hello " <> world = "Hello World"

# But only from the left side:
hello <> " World" = "Hello World"
# MatchError


# Cannot invoke functions on the left side of a pattern match:
length([1, [2], 3]) = 3
# CompileError


# You can match (partially) in function clauses.

# This here defines an anonymous function with two clauses.
# It's the same as defining two function clauses.
fun = fn
  %{status: status} -> status
  %{age: age} -> age
end

fun.(%{status: :active, height: 190.47}) # => :active
fun.(%{age: 32, height: 190.47}) # => 32

# Or in Module functions
defmodule Profile do
  def details(%{status: status}), do: status
  def details(%{age: age}), do: age
end

Profile.details(%{status: :inactive, height: 190.47}) # => :inactive
Profile.details(%{age: 30, height: 190.47}) # => 30


# Example of a recursive implementation using pattern matching:
defmodule Fib do
  def calculate(0), do: 0

  def calculate(1), do: 1

  def calculate(n) when n > 1 do
    calculate(n - 1) + calculate(n - 2)
  end
end
