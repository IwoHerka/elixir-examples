# A Struct is an extension of a Map and is defined inside a Module. It allows you
# to define fields at compile-time, require certain fields, set default values,
# and it raises if you try to set a field that doesn't exist. You can define a
# struct with defstruct/1.

defmodule User do
  defstruct [:name, :age]
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

defmodule Product do
  defstruct [:name, :price, quantity: 1, available: true]
end

# Fields without default values are set to nil
%Product{}
# => %Product{name: nil, price: nil, quantity: 1, available: true}

%Product{name: "Laptop", price: 999.99}
# => %Product{name: "Laptop", price: 999.99, quantity: 1, available: true}

# Using @enforce_keys to require fields
defmodule Account do
  @enforce_keys [:username, :email]
  defstruct [:username, :email, :verified, created_at: nil]
end

%Account{username: "alice", email: "alice@example.com"}
# => %Account{username: "alice", email: "alice@example.com", verified: nil, created_at: nil}

%Account{username: "bob"}
# => ** (ArgumentError) the following keys must also be given when building struct Account: [:email]


# -- Nested structs --

defmodule Address do
  defstruct [:street, :city, :zip]
end

defmodule Person do
  defstruct [:name, :address]
end

address = %Address{street: "123 Main St", city: "Springfield", zip: "12345"}
person = %Person{name: "Alice", address: address}
# => %Person{name: "Alice", address: %Address{street: "123 Main St", city: "Springfield", zip: "12345"}}

# Accessing nested fields
person.address.city
# => "Springfield"

# Updating nested structs
updated_person = %{person | address: %{person.address | city: "Shelbyville"}}
# => %Person{name: "Alice", address: %Address{street: "123 Main St", city: "Shelbyville", zip: "12345"}}


# -- Working with Map functions --

defmodule Book do
  defstruct [:title, :author, :year]
end

book = %Book{title: "Elixir in Action", author: "Saša Jurić", year: 2019}

# Convert struct to a map
Map.from_struct(book)
# => %{title: "Elixir in Action", author: "Saša Jurić", year: 2019}

# Get keys
Map.keys(book)
# => [:__struct__, :author, :title, :year]

# Get values
Map.values(book)
# => [Book, "Saša Jurić", "Elixir in Action", 2019]

# Update multiple fields
Map.merge(book, %{year: 2020, author: "Saša Jurić (Updated)"})
# => ** (ArgumentError) structs can only be merged with structs of the same type

# Use struct/2 instead for merging
struct(book, year: 2020)
# => %Book{title: "Elixir in Action", author: "Saša Jurić", year: 2020}


# -- Struct functions --

defmodule Car do
  defstruct [:make, :model, :year]

  def new(make, model, year) do
    %Car{make: make, model: model, year: year}
  end

  def to_string(%Car{make: make, model: model, year: year}) do
    "#{year} #{make} #{model}"
  end

  def age(%Car{year: year}) do
    DateTime.utc_now().year - year
  end
end

car = Car.new("Tesla", "Model 3", 2020)
# => %Car{make: "Tesla", model: "Model 3", year: 2020}

Car.to_string(car)
# => "2020 Tesla Model 3"

Car.age(car)
# => 5 (or current year - 2020)


# -- Pattern matching with structs --

defmodule Order do
  defstruct [:id, :status, :total]
end

defmodule OrderProcessor do
  def process(%Order{status: :pending} = order) do
    {:ok, "Processing order #{order.id}"}
  end

  def process(%Order{status: :completed}) do
    {:error, "Order already completed"}
  end

  def process(%Order{status: :cancelled}) do
    {:error, "Order is cancelled"}
  end
end

order1 = %Order{id: 1, status: :pending, total: 100.0}
OrderProcessor.process(order1)
# => {:ok, "Processing order 1"}

order2 = %Order{id: 2, status: :completed, total: 200.0}
OrderProcessor.process(order2)
# => {:error, "Order already completed"}


# -- Using structs with guards --

defmodule Employee do
  defstruct [:name, :salary, :department]

  def high_earner?(%Employee{salary: salary}) when salary > 100_000 do
    true
  end

  def high_earner?(%Employee{}) do
    false
  end

  def in_department?(%Employee{department: dept}, dept) when is_binary(dept) do
    true
  end

  def in_department?(%Employee{}, _) do
    false
  end
end

emp1 = %Employee{name: "Alice", salary: 120_000, department: "Engineering"}
Employee.high_earner?(emp1)
# => true

emp2 = %Employee{name: "Bob", salary: 80_000, department: "Marketing"}
Employee.high_earner?(emp2)
# => false

Employee.in_department?(emp1, "Engineering")
# => true


# -- Updating multiple fields --

defmodule Config do
  defstruct host: "localhost", port: 8080, ssl: false, timeout: 5000
end

config = %Config{}
# => %Config{host: "localhost", port: 8080, ssl: false, timeout: 5000}

# Update single field
%{config | ssl: true}
# => %Config{host: "localhost", port: 8080, ssl: true, timeout: 5000}

# Update multiple fields
%{config | host: "example.com", port: 443, ssl: true}
# => %Config{host: "example.com", port: 443, ssl: true, timeout: 5000}

# Using struct/2 for dynamic updates
updates = %{host: "api.example.com", ssl: true}
struct(config, Map.to_list(updates))
# => %Config{host: "api.example.com", port: 8080, ssl: true, timeout: 5000}


# -- Structs with derived protocols --

defmodule Point do
  @derive {Inspect, only: [:x, :y]}
  defstruct [:x, :y, :metadata]
end

point = %Point{x: 10, y: 20, metadata: %{created_at: ~N[2025-01-01 00:00:00]}}
IO.inspect(point)
# => %Point{x: 10, y: 20}
# (metadata is hidden in inspect output)


# -- Real-world example: Blog post --

defmodule BlogPost do
  defstruct [:id, :title, :content, :author, :tags, published: false, views: 0]

  def new(title, content, author, tags \\ []) do
    %BlogPost{
      id: generate_id(),
      title: title,
      content: content,
      author: author,
      tags: tags
    }
  end

  def publish(%BlogPost{} = post) do
    %{post | published: true}
  end

  def add_tag(%BlogPost{tags: tags} = post, tag) do
    %{post | tags: [tag | tags]}
  end

  def increment_views(%BlogPost{views: views} = post) do
    %{post | views: views + 1}
  end

  defp generate_id do
    :crypto.strong_rand_bytes(8) |> Base.encode16()
  end
end

post = BlogPost.new("Elixir Structs", "Structs are awesome!", "Alice", ["elixir", "tutorial"])
# => %BlogPost{id: "...", title: "Elixir Structs", content: "Structs are awesome!",
#              author: "Alice", tags: ["elixir", "tutorial"], published: false, views: 0}

post = post |> BlogPost.publish() |> BlogPost.increment_views()
# => %BlogPost{..., published: true, views: 1}

post = BlogPost.add_tag(post, "beginner")
# => %BlogPost{..., tags: ["beginner", "elixir", "tutorial"]}
