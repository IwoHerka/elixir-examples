# --- Map ---

foo = fn x -> x * 2 end

defmodule Foo do
  def foo(x) do
    x * 2
  end
end

Enum.map([1, 2, 3], Foo.foo/1)
Enum.map([1, 2, 3], foo)

users = [
  %{name: "Alice", email: "alice@example.com", active: true},
  %{name: "Bob", email: "bob@sample.org", active: false},
  %{name: "Charlie", email: "charlie@example.com", active: true}
]
user = Enum.map(users, fn user -> user.email end)
# ["alice@example.com", "bob@sample.org", "charlie@example.com"]


temperatures_celsius = [0, 15, 30, 100, -5]
Enum.map(temperatures_celsius, fn temp_c ->
  temp_f = round(temp_c * 9 / 5 + 32)
  "#{temp_f}°F"
end)
# ["32°F", "59°F", "86°F", "212°F", "23°F"]


values = [10, "hello", :world, %{a: 1}]
Enum.map(values, fn value -> {:ok, value} end)
# [{:ok, 10}, {:ok, "hello"}, {:ok, :world}, {:ok, %{a: 1}}]


# --- Filter ---


users = [
  %{name: "Alice", is_admin: true, id: 1},
  %{name: "Bob", is_admin: false, id: 2},
  %{name: "Charlie", is_admin: true, id: 3},
  %{name: "David", is_admin: false, id: 4}
]
Enum.filter(users, fn user -> user.is_admin == true end)
# [%{name: "Alice", is_admin: true, id: 1}, %{name: "Charlie", is_admin: true, id: 3}]


words = ["Apple", "Banana", "Ant", "Bear", "apricot", "Avocado"]
Enum.filter(words, fn word ->
  String.downcase(word) |> String.starts_with?("a")
end)
# ["Apple", "Ant", "apricot", "Avocado"]


numbers = 1..50
Enum.filter(numbers, fn n -> rem(n, 3) == 0 && rem(n, 5) == 0 end)
# [15, 30, 45]


# --- Reduce ---







numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
initial_groups = %{even: [], odd: []}

Enum.reduce(numbers, initial_groups, fn number, acc ->
  if rem(number, 2) == 0 do
    Map.update!(acc, :even, fn list -> [number | list] end)
  else
    Map.update!(acc, :odd, fn list -> [number | list] end)
  end
end)
# %{even: [8, 6, 4, 2], odd: [9, 7, 5, 3, 1]}


words = ["elixir", "is", "a", "functional", "language", "programming"]
Enum.reduce(words, "", fn word, longest_so_far ->
  if String.length(word) > String.length(longest_so_far) do
    word
  else
    longest_so_far
  end
end)
# "programming"


scores = [%{points: 10}, %{points: 25}, %{points: 5}, %{points: 15}]
Enum.reduce(scores, 0, fn score_map, total_accumulator ->
  total_accumulator + score_map.points
end)
# 55


# Building a frequency map from a list
letters = ["a", "b", "a", "c", "b", "a", "d", "c", "a"]
Enum.reduce(letters, %{}, fn letter, freq_map ->
  Map.update(freq_map, letter, 1, fn count -> count + 1 end)
end)
# %{"a" => 4, "b" => 2, "c" => 2, "d" => 1}


# Flattening and transforming nested structures
nested_data = [
  %{name: "Alice", tags: ["elixir", "phoenix"]},
  %{name: "Bob", tags: ["ruby", "rails"]},
  %{name: "Charlie", tags: ["elixir", "nerves"]}
]
Enum.reduce(nested_data, [], fn person, acc ->
  tagged_entries = Enum.map(person.tags, fn tag -> {person.name, tag} end)
  acc ++ tagged_entries
end)
# [{"Alice", "elixir"}, {"Alice", "phoenix"}, {"Bob", "ruby"}, {"Bob", "rails"},
#  {"Charlie", "elixir"}, {"Charlie", "nerves"}]
