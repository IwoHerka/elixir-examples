# -- Enumerables & streams --
# In Elixir, Enumerables and Streams provide powerful tools for working with
# collections of data.  They allow for efficient data processing and
# manipulation, enabling developers to write clean and expressive code.

# -- Enumerables --
# An Enumerable is a data structure that can be traversed, such as lists, maps,
# and ranges.  The Enumerable module provides a set of functions to work with
# these data structures.

# Basic usage of Enumerables:
list = [1, 2, 3, 4, 5]

# Using Enum.map/2 to transform each element:
squared = Enum.map(list, fn x -> x * x end)
# => [1, 4, 9, 16, 25]

# Using Enum.filter/2 to filter elements:
even_numbers = Enum.filter(list, fn x -> rem(x, 2) == 0 end)
# => [2, 4]

# Using Enum.reduce/3 to accumulate a value:
sum = Enum.reduce(list, 0, fn x, acc -> x + acc end)
# => 15

# -- Enumerating Different Data Structures with Rules --

# Enumerating a List:
# Lists are simple collections of elements. They maintain the order of elements and allow duplicates.
list = [1, 2, 3, 4, 5]
Enum.each(list, fn x -> IO.puts(x) end)

# Enumerating a Map:
# Maps are collections of key-value pairs. Keys are unique, and the order is not guaranteed.
map = %{"a" => 1, "b" => 2, "c" => 3}
Enum.each(map, fn {key, value} -> IO.puts("#{key}: #{value}") end)

# Enumerating a Range:
# Ranges represent a sequence of numbers. They are defined by a start and an end value.
range = 1..5
Enum.each(range, fn x -> IO.puts(x) end)

# Enumerating a Keyword List:
# Keyword lists are lists of tuples, where the first element is an atom. They maintain order and allow duplicate keys.
keyword_list = [a: 1, b: 2, c: 3]
Enum.each(keyword_list, fn {key, value} -> IO.puts("#{key}: #{value}") end)

# Enumerating a Tuple:
# Tuples are fixed-size collections of elements. They are not directly enumerable, so they need to be converted to a list first.
tuple = {:a, :b, :c}
tuple
|> Tuple.to_list()
|> Enum.each(fn x -> IO.puts(x) end)

# Enumerating a Binary:
# Binaries are sequences of bytes. To enumerate a binary string, it must be converted to a list of codepoints.
binary = "hello"
binary
|> String.codepoints()
|> Enum.each(fn x -> IO.puts(x) end)


# -- Streams --
# Streams provide a way to work with large collections of data without loading
# everything into memory.  They are lazy, meaning that they only compute values
# as needed.

# Creating a Stream:
stream = Stream.map(1..100_000_000_000, fn x -> x ** x end) # Expensive

# To realize the stream, you can convert it to a list:
squared_stream = Enum.to_list(stream)
# => [1, 4, 9, 16, 25]

# Streams can also be combined with other functions:
stream =
  list
  |> Stream.filter(fn x -> rem(x, 2) == 0 end)
  |> Stream.map(fn x -> x * x end)


# Streams are composable, meaning you can chain multiple operations together to
# create more complex data processing pipelines.

# Realizing the stream:
even_squared = Enum.to_list(stream)
# => [4, 16]

# -- Combining Enumerables and Streams --
# You can use both Enumerables and Streams together for efficient data processing.
# For example, you can filter a list and then map the results:

result =
  list
  |> Stream.filter(fn x -> rem(x, 2) == 0 end)
  |> Enum.map(fn x -> x * x end)
# => [4, 16]

# However, then Stream is passed to Enum functions, it is realized.

# -- Limitations --
# - They cannot be used with functions that require the entire collection at once.
# - They are not suitable for operations that need to be performed in a specific order.
