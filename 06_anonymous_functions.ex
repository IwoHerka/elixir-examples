# -- Anonymous functions --
# Anonymous functions in Elixir are delimited by the keywords fn and end:

add = fn a, b -> a + b end
# => #Function<12.71889879/2 in :erl_eval.expr/5>

# Anonymous functions can be called using dot notation:
add.(1, 2)
# => 3

is_function(add)
# => true

i add
# =>
# Term
#   #Function<12.71889879/2 in :erl_eval.expr/5>
# Data type
#   Function
# Type
#   local
# Arity
#   0
# Description
#   This is an anonymous function.
# Implemented protocols
#   Enumerable, IEx.Info, Inspect


# General form of anonymous functions:
fn arguments -> expression end


# Arguments are optional, but if provided, they must be separated by commas.
fn -> "No arguments" end
fn a, b, c -> a + b + c end


# Anonymous functions in Elixir are also identified by the number of arguments
# they receive. We can check if a function is of any given arity by using
# is_function/2:
is_function(add, 2)
# => true

is_function(add, 1)
# => false


# -- Closures --
# All functions in Elixirs have closures, which means that they can capture
# variables from the environment in which they are defined, but not modify them:

x = 42

(fn ->
  IO.puts("x = #{x}")
  x = 0
  IO.puts("x = #{x}")
end).()
# =>
# x =42
# x =0

x
# => 42


# -- Clauses and guards --
# Anonymous functions support clauses and guards, which allows to define multiple
# patterns and conditions for the same function:
f = fn
  x, y when x > 0 -> x + y

  x, y -> x * y
end

f.(1, 2)
# => 4

f.(-1, 3)
# => -3

# Number of arguments in each clause must be the same.


# -- Capture operator --
# Capture operator & can be used to 'capture' an existing function under a name, to be
# passed around as argument:
fun = &String.upcase/1

fun.("hello")
# => "HELLO"

# We can also capture operators:
add = &+/2

add.(1, 2)
# => 3


# Capture syntax can also be used to create anonymous functions:
f = &(&1 + &2)

f.(1, 2)
# => 3

f = &"Hello #{&1}"

f.("world")
# => "Hello world"

# This is equivalent to:
f = fn name -> "Hello #{name}" end

# The general form is:
&expression

# Where positional arguments are captured using &1, &2, etc.
