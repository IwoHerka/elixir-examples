# Keyword lists are lists of key-value pairs,
# often used as a way to pass configuration options to functions.
#
# - They are a blend of lists and maps.
# - They are unordered, which means that the order of the key-value pairs is not guaranteed.
# - They are also heterogenous, which means that the keys and values can be of different types.
# - They can contain duplicate keys.
# - They are Enumerable, which means that they support Enum module.

keyword = [name: "Peter", age: 32, name: "Pietah"]

# ^ is the same as:
keyword = [{:name, "Peter"}, {:age, 32}, {:name, "Pietah"}]


# Access an element using the bracket notation
keyword[:age] # => 32

# But it will only return the first key
keyword[:name] # => "Peter"

# You can also use a helper function
Keyword.get(keyword, :age) # => 32


# Replace an existing value with a new one
Keyword.replace(keyword, :age, 33)
# => [name: "Peter", age: 33, name: "Pietah"]

# But when you update a duplicate key, it will only keep the new value and
# remove the rest
Keyword.replace(keyword, :name, "Pieter")
# => [name: "Pieter", age: 32]


# Delete all pairs that have a given key
Keyword.delete(keyword, :name)
# => [age: 32]

# Only delete the first occurrence
Keyword.delete_first(keyword, :name)
# => [age: 32, name: "Pietah"]


# You can also merge two keyword lists, where the second list's keys will overwrite the first's
Keyword.merge(keyword, [age: 40, city: "New York"])
# => [name: "Peter", age: 40, name: "Pietah", city: "New York"]


# Other functions from Keyword module include:
# - Keyword.has_key?/2
# - Keyword.keys/1
# - Keyword.values/1
# - Keyword.fetch/2
