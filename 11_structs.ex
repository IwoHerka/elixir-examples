# A Struct is an extension of a Map and is defined inside a Module. It allows you
# to define fields at compile-time, require certain fields, set default values,
# and it raises if you try to set a field that doesn't exist. You can define a
# struct with defstruct/1.

defmodule User do
  defstruct name: "John", age: 27
end

%User{}
# => %User{name: "John", age: 27}

%User{name: "Jane"}
# => %User{name: "Jane", age: 27}

# Structs define a new type:
i %User{}
# =>
# Term
#   %User{name: "John", age: 27}
# Data type
#   User
# Description
#   This is a struct. Structs are maps with a __struct__ key.
# Reference modules
#   User, Map
# Implemented protocols
#   IEx.Info, Inspect

# -- Accessing and updating --

john = %User{}
# => %User{age: 27, name: "John"}

john.name
# => "John"

jane = %{john | name: "Jane"}
# => %User{age: 27, name: "Jane"}

%{jane | oops: :field}
# =>** (KeyError) key :oops not found in: %User{age: 27, name: "Jane"}


# -- Pattern matching --

%User{name: name} = john
# => %User{age: 27, name: "John"}

name
# =>"John"

%User{} = %{}
# => ** (MatchError) no match of right hand side value: %{}


# -- Structs are maps --

is_map(john)
# => true

john.__struct__
# => User

# However, structs do not inherit any of the protocols that maps do. For example,
# you can neither enumerate nor access a struct:

john = %User{}
# => %User{age: 27, name: "John"}

john[:name]
# => ** (UndefinedFunctionError) function User.fetch/2 is undefined (User does not implement the Access behaviour)
#              User.fetch(%User{age: 27, name: "John"}, :name)

Enum.each(john, fn {field, value} -> IO.puts(value) end)
# => ** (Protocol.UndefinedError) protocol Enumerable not implemented for %User{age: 27, name: "John"} of type User (a struct)


# -- Default values & required fields --
