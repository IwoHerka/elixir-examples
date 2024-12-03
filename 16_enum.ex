# -- Enum Module --
# The `Enum` module provides a set of algorithms for working with enumerables.
# Enumerables are collections that can be iterated over, such as lists, maps, and ranges.

# -- Enum.map/2 --
# Applies a function to each element in the collection and returns a new list with the results.

Enum.map([1, 2, 3], fn x -> x * 2 end)
# => [2, 4, 6]

# -- Enum.each/2 --
# Iterates over the collection, applying the function to each element, but returns `:ok`.

Enum.each([1, 2, 3], fn x -> IO.puts(x) end)
# Output: 1 2 3
# => :ok

# -- Enum.reduce/3 --
# Reduces the collection to a single value by applying a function to an accumulator and each element.

Enum.reduce([1, 2, 3], 0, fn x, acc -> acc + x end)
# => 6

# -- Enum.filter/2 --
# Returns a new list containing only the elements for which the function returns a truthy value.

Enum.filter([1, 2, 3, 4], fn x -> rem(x, 2) == 0 end)
# => [2, 4]

# -- Enum.reject/2 --
# Returns a new list excluding the elements for which the function returns a truthy value.

Enum.reject([1, 2, 3, 4], fn x -> rem(x, 2) == 0 end)
# => [1, 3]

# -- Enum.all?/2 --
# Returns `true` if the function returns a truthy value for all elements, otherwise `false`.

Enum.all?([1, 2, 3], fn x -> x > 0 end)
# => true

# -- Enum.any?/2 --
# Returns `true` if the function returns a truthy value for at least one element, otherwise `false`.

Enum.any?([1, 2, 3], fn x -> x < 0 end)
# => false

# -- Enum.find/3 --
# Finds the first element for which the function returns a truthy value. Returns `nil` if no match is found.

Enum.find([1, 2, 3], fn x -> x > 1 end)
# => 2

# -- Enum.sort/1 --
# Sorts the collection in ascending order.

Enum.sort([3, 1, 2])
# => [1, 2, 3]

# -- Enum.uniq/1 --
# Returns a new list with duplicate elements removed.

Enum.uniq([1, 2, 2, 3, 3, 3])
# => [1, 2, 3]

# -- Enum.join/2 --
# Joins the elements of the collection into a string, separated by the given separator.

Enum.join(["a", "b", "c"], "-")
# => "a-b-c"

# -- Enum.chunk_every/2 --
# Splits the collection into chunks of the specified size.

Enum.chunk_every([1, 2, 3, 4, 5], 2)
# => [[1, 2], [3, 4], [5]]

# -- Enum.zip/2 --
# Combines two collections into a list of tuples.

Enum.zip([1, 2, 3], [:a, :b, :c])
# => [{1, :a}, {2, :b}, {3, :c}]

# -- Enum.take/2 --
# Takes the first `n` elements from the collection.

Enum.take([1, 2, 3, 4, 5], 3)
# => [1, 2, 3]

# -- Enum.drop/2 --
# Drops the first `n` elements from the collection.

Enum.drop([1, 2, 3, 4, 5], 3)
# => [4, 5]

# -- Enum.split/2 --
# Splits the collection into two lists, the first containing `n` elements, the second containing the rest.

Enum.split([1, 2, 3, 4, 5], 3)
# => {[1, 2, 3], [4, 5]}

# -- Enum.group_by/3 --
# Groups the elements of the collection by the result of the function.

Enum.group_by([1, 2, 3, 4], fn x -> rem(x, 2) end)
# => %{0 => [2, 4], 1 => [1, 3]}

# -- Enum.max/1 and Enum.min/1 --
# Returns the maximum or minimum element in the collection.

Enum.max([1, 2, 3, 4, 5])
# => 5

Enum.min([1, 2, 3, 4, 5])
# => 1

# -- Enum.count/1 --
# Returns the number of elements in the collection.

Enum.count([1, 2, 3, 4, 5])
# => 5

# -- Enum.member?/2 --
# Checks if a value is present in the collection.

Enum.member?([1, 2, 3], 2)
# => true

# -- Enum.at/2 --
# Returns the element at the specified index.

Enum.at([1, 2, 3], 1)
# => 2

# -- Enum.reverse/1 --
# Reverses the order of elements in the collection.

Enum.reverse([1, 2, 3])
# => [3, 2, 1]

# -- Enum.flat_map/2 --
# Maps and flattens the collection in one pass.

Enum.flat_map([1, 2, 3], fn x -> [x, x * 2] end)
# => [1, 2, 2, 4, 3, 6]

# -- Enum.frequencies/1 --
# Returns a map with the count of each element in the collection.

Enum.frequencies([1, 2, 2, 3, 3, 3])
# => %{1 => 1, 2 => 2, 3 => 3}

# -- Enum.group_by/3 --
# Groups the elements of the collection by the result of the function.

Enum.group_by([1, 2, 3, 4], fn x -> rem(x, 2) end)
# => %{0 => [2, 4], 1 => [1, 3]}

# -- Enum.intersperse/2 --
# Inserts the given element between each element of the collection.

Enum.intersperse([1, 2, 3], :a)
# => [1, :a, 2, :a, 3]

# -- Enum.into/2 --
# Inserts the elements of the collection into the given collectable.

Enum.into([1, 2, 3], [])
# => [1, 2, 3]

Enum.into([a: 1, b: 2], %{})
# => %{a: 1, b: 2}

# -- Enum.join/2 --
# Joins the elements of the collection into a string separated by the given separator.

Enum.join([1, 2, 3], ", ")
# => "1, 2, 3"
