# -- Enum Module --
# The `Enum` module provides a set of algorithms for working with enumerables.
# Enumerables are collections that can be iterated over, such as lists, maps, and ranges.

# -- Enum.map/2 --
# Applies a function to each element in the collection and returns a new list with the results.

Enum.map([1, 2, 3], fn x -> x * 2 end)
# => [2, 4, 6]

Enum.map(["hello", "world"], fn s -> String.upcase(s) end)
# => ["HELLO", "WORLD"]

Enum.map([1, 2, 3, 4], fn x -> x * x end)
# => [1, 4, 9, 16]

# -- Enum.each/2 --
# Iterates over the collection, applying the function to each element, but returns `:ok`.

Enum.each([1, 2, 3], fn x -> IO.puts(x) end)
# Output: 1 2 3
# => :ok

Enum.each(["Alice", "Bob"], fn name -> IO.puts("Hello, #{name}!") end)
# Output: Hello, Alice! Hello, Bob!
# => :ok

Enum.each([10, 20, 30], fn x -> IO.inspect(x * 2) end)
# Output: 20 40 60
# => :ok

# -- Enum.reduce/3 --
# Reduces the collection to a single value by applying a function to an accumulator and each element.

Enum.reduce([1, 2, 3], 0, fn x, acc -> acc + x end)
# => 6

Enum.reduce([2, 3, 4], 1, fn x, acc -> acc * x end)
# => 24

Enum.reduce(["a", "b", "c"], "", fn x, acc -> acc <> x end)
# => "abc"

# -- Enum.filter/2 --
# Returns a new list containing only the elements for which the function returns a truthy value.

Enum.filter([1, 2, 3, 4], fn x -> rem(x, 2) == 0 end)
# => [2, 4]

Enum.filter([10, 15, 20, 25], fn x -> x > 15 end)
# => [20, 25]

Enum.filter(["apple", "banana", "apricot"], fn s -> String.starts_with?(s, "a") end)
# => ["apple", "apricot"]

# -- Enum.reject/2 --
# Returns a new list excluding the elements for which the function returns a truthy value.

Enum.reject([1, 2, 3, 4], fn x -> rem(x, 2) == 0 end)
# => [1, 3]

Enum.reject([10, 15, 20, 25], fn x -> x > 15 end)
# => [10, 15]

Enum.reject(["apple", "banana", "apricot"], fn s -> String.starts_with?(s, "b") end)
# => ["apple", "apricot"]

# -- Enum.all?/2 --
# Returns `true` if the function returns a truthy value for all elements, otherwise `false`.

Enum.all?([1, 2, 3], fn x -> x > 0 end)
# => true

Enum.all?([2, 4, 6], fn x -> rem(x, 2) == 0 end)
# => true

Enum.all?([1, 2, 3], fn x -> x < 3 end)
# => false

# -- Enum.any?/2 --
# Returns `true` if the function returns a truthy value for at least one element, otherwise `false`.

Enum.any?([1, 2, 3], fn x -> x < 0 end)
# => false

Enum.any?([1, 2, 3], fn x -> x > 2 end)
# => true

Enum.any?([-5, 0, 5], fn x -> x == 0 end)
# => true

# -- Enum.find/3 --
# Finds the first element for which the function returns a truthy value. Returns `nil` if no match is found.

Enum.find([1, 2, 3], fn x -> x > 1 end)
# => 2

Enum.find([10, 20, 30], fn x -> rem(x, 20) == 0 end)
# => 20

Enum.find([1, 2, 3], :my_special_value, fn x -> x > 10 end)
# => nil

# -- Enum.sort/1 --
# Sorts the collection in ascending order.

Enum.sort([3, 1, 2])
# => [1, 2, 3]

Enum.sort(["banana", "apple", "cherry"])
# => ["apple", "banana", "cherry"]

Enum.sort([5, 2, 8, 1, 9], :desc)
# => [9, 8, 5, 2, 1]

# -- Enum.uniq/1 --
# Returns a new list with duplicate elements removed.

Enum.uniq([1, 2, 2, 3, 3, 3])
# => [1, 2, 3]

Enum.uniq(["a", "b", "a", "c", "b"])
# => ["a", "b", "c"]

Enum.uniq([1, 1, 1, 1])
# => [1]

# -- Enum.join/2 --
# Joins the elements of the collection into a string, separated by the given separator.

Enum.join(["a", "b", "c"], "-")
# => "a-b-c"

Enum.join([1, 2, 3], ", ")
# => "1, 2, 3"

Enum.join(["Hello", "World"], " ")
# => "Hello World"

# -- Enum.chunk_every/2 --
# Splits the collection into chunks of the specified size.

Enum.chunk_every([1, 2, 3, 4, 5], 2)
# => [[1, 2], [3, 4], [5]]

Enum.chunk_every([1, 2, 3, 4, 5, 6], 3)
# => [[1, 2, 3], [4, 5, 6]]

Enum.chunk_every(["a", "b", "c", "d", "e", "f", "g"], 4)
# => [["a", "b", "c", "d"], ["e", "f", "g"]]

# -- Enum.zip/2 --
# Combines two collections into a list of tuples.

Enum.zip([1, 2, 3], [:a, :b, :c])
# => [{1, :a}, {2, :b}, {3, :c}]

Enum.zip(["name", "age"], ["Alice", 30])
# => [{"name", "Alice"}, {"age", 30}]

Enum.zip([10, 20], [100, 200, 300])
# => [{10, 100}, {20, 200}]

# -- Enum.take/2 --
# Takes the first `n` elements from the collection.

Enum.take([1, 2, 3, 4, 5], 3)
# => [1, 2, 3]

Enum.take(["a", "b", "c", "d"], 2)
# => ["a", "b"]

Enum.take([10, 20, 30], 10)
# => [10, 20, 30]

# -- Enum.drop/2 --
# Drops the first `n` elements from the collection.

Enum.drop([1, 2, 3, 4, 5], 3)
# => [4, 5]

Enum.drop(["a", "b", "c", "d"], 2)
# => ["c", "d"]

Enum.drop([10, 20, 30], 10)
# => []

# -- Enum.split/2 --
# Splits the collection into two lists, the first containing `n` elements, the second containing the rest.

Enum.split([1, 2, 3, 4, 5], 3)
# => {[1, 2, 3], [4, 5]}

Enum.split(["a", "b", "c", "d"], 2)
# => {["a", "b"], ["c", "d"]}

Enum.split([10, 20, 30], 0)
# => {[], [10, 20, 30]}

# -- Enum.group_by/3 --
# Groups the elements of the collection by the result of the function.

Enum.group_by([1, 2, 3, 4], fn x -> rem(x, 2) end)
# => %{0 => [2, 4], 1 => [1, 3]}

Enum.group_by(["apple", "apricot", "banana", "blueberry"], fn s -> String.first(s) end)
# => %{"a" => ["apple", "apricot"], "b" => ["banana", "blueberry"]}

Enum.group_by([1, 2, 3, 4, 5, 6], fn x -> div(x, 3) end)
# => %{0 => [1, 2], 1 => [3, 4, 5], 2 => [6]}

# -- Enum.max/1 and Enum.min/1 --
# Returns the maximum or minimum element in the collection.

Enum.max([1, 2, 3, 4, 5])
# => 5

Enum.max([42])
# => 42

Enum.max([-10, -5, -20])
# => -5

Enum.min([1, 2, 3, 4, 5])
# => 1

Enum.min([100, 50, 75])
# => 50

Enum.min([-10, -5, -20])
# => -20

# -- Enum.count/1 --
# Returns the number of elements in the collection.

Enum.count([1, 2, 3, 4, 5])
# => 5

Enum.count(["a", "b", "c"])
# => 3

Enum.count([])
# => 0

# -- Enum.member?/2 --
# Checks if a value is present in the collection.

Enum.member?([1, 2, 3], 2)
# => true

Enum.member?(["apple", "banana"], "cherry")
# => false

Enum.member?([10, 20, 30], 10)
# => true

# -- Enum.at/2 --
# Returns the element at the specified index.

Enum.at([1, 2, 3], 1)
# => 2

Enum.at(["a", "b", "c"], 0)
# => "a"

Enum.at([10, 20, 30], 5)
# => nil

# -- Enum.reverse/1 --
# Reverses the order of elements in the collection.

Enum.reverse([1, 2, 3])
# => [3, 2, 1]

Enum.reverse(["a", "b", "c", "d"])
# => ["d", "c", "b", "a"]

Enum.reverse([42])
# => [42]

# -- Enum.flat_map/2 --
# Maps and flattens the collection in one pass.

Enum.flat_map([1, 2, 3], fn x -> [x, x * 2] end)
# => [1, 2, 2, 4, 3, 6]

Enum.flat_map([[1, 2], [3, 4]], fn list -> list end)
# => [1, 2, 3, 4]

Enum.flat_map(["hello", "world"], fn s -> String.graphemes(s) end)
# => ["h", "e", "l", "l", "o", "w", "o", "r", "l", "d"]

# -- Enum.frequencies/1 --
# Returns a map with the count of each element in the collection.

Enum.frequencies([1, 2, 2, 3, 3, 3])
# => %{1 => 1, 2 => 2, 3 => 3}

Enum.frequencies(["a", "b", "a", "c", "b", "a"])
# => %{"a" => 3, "b" => 2, "c" => 1}

Enum.frequencies([true, false, true, true])
# => %{true => 3, false => 1}

# -- Enum.group_by/3 --
# Groups the elements of the collection by the result of the function.

Enum.group_by([1, 2, 3, 4], fn x -> rem(x, 2) end)
# => %{0 => [2, 4], 1 => [1, 3]}

# -- Enum.intersperse/2 --
# Inserts the given element between each element of the collection.

Enum.intersperse([1, 2, 3], :a)
# => [1, :a, 2, :a, 3]

Enum.intersperse(["apple", "banana", "cherry"], " and ")
# => ["apple", " and ", "banana", " and ", "cherry"]

Enum.intersperse([42], 0)
# => [42]

# -- Enum.into/2 --
# Inserts the elements of the collection into the given collectable.

Enum.into([1, 2, 3], [])
# => [1, 2, 3]

Enum.into([a: 1, b: 2], %{})
# => %{a: 1, b: 2}

Enum.into(%{a: 1, b: 2}, [])
# => [a: 1, b: 2]

Enum.into([{:x, 10}, {:y, 20}], %{z: 30})
# => %{x: 10, y: 20, z: 30}

# -- Enum.join/2 --
# Joins the elements of the collection into a string separated by the given separator.

Enum.join([1, 2, 3], ", ")
# => "1, 2, 3"

Enum.join(["Ruby", "Python", "Elixir"], " | ")
# => "Ruby | Python | Elixir"

Enum.join([10, 20, 30])
# => "102030"
