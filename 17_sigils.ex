# -- Sigils in Elixir --
# Sigils in Elixir provide a convenient way to work with literals, allowing
# to define custom syntax for creating data structures. They are particularly
# useful for strings, regular expressions, lists, and more.

# Elixir provides several built-in sigils for common data types.

# 1. Sigil for Strings: ~s
# The ~s sigil is used to create strings. It allows for interpolation and ignores escape sequences.

string = ~s(Hello, World!)
# => Hello, World!

# You can also use delimiters other than parentheses:
string_with_delimiters = ~s|Hello, World!|
 # => Hello, World!

# 2. Sigil for charlists: ~c
# The ~c sigil creates a charlist, which is a list of character codes.

charlist = ~c(Hello)
# => 'Hello'

# 3. Sigil for regular expressions: ~r
# The ~r sigil is used to create regular expressions.

regex = ~r/\d+/
Regex.match?(regex, "123")
# => true

# 4. Sigil for lists: ~w
# The ~w sigil creates a list of words, splitting by whitespace.

word_list = ~w(Hello World Elixir)
# => ["Hello", "World", "Elixir"]

# 5. Sigil for lists of strings: ~W
# The ~W sigil creates a list of strings, also splitting by whitespace but
# allowing for interpolation.

~W(Hello #{1 + 1} World)
# => ["Hello", "2", "World"]

# -- Custom sigils --
# You can define your own sigils by implementing the `sigil_*` functions in a module.

defmodule Sigils do
  def sigil_x(string, _opts) do
    String.upcase(string)  # Converts the string to uppercase
  end
end

# Using the custom sigil:
custom_string = ~x(hello)
# => HELLO

# -- Options with sigils --
# Sigils can also accept options. For example, the ~r sigil can take options for
# case sensitivity.

case_sensitive_regex = ~r/\d+/i  # Case insensitive
Regex.match?(case_sensitive_regex, "123")
# => true

# -- Limitations --
# - Sigils are not as flexible as functions and are limited to specific use cases.
# - Custom sigils must follow the naming convention of `sigil_*` and can only be defined in modules.
