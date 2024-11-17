# Simplest conditional expression in Elixir is if/else:

if condition do
  expression
  x = 2
else
  expression
end


if condition do
  expression
end


# There are no 'else if' in Elixir.
# Example:

n = 15

if rem(n, 15) == 0 do
  IO.puts "FizzBuzz"
else
  if rem(n, 3) == 0 do
    IO.puts "Fizz"
  else
    if rem(n, 5) == 0 do
      IO.puts "Buzz"
    else
      IO.puts n
    end
  end
end


# 'unless' is just an alias for 'if' with inverted condition:
unless condition do
  expression
end

# Which is equivalent to:
if not condition do
  expression
end


# Variables in Elixir are block-scoped.
# This means that variables defined in an 'if' block are not visible outside of it:

if true do
  x = 1
end

x # => undefined

# And any changes to it will not be reflected outside of the block:
x = 1

if true do
  x = x + 1
end

x
# => 1
