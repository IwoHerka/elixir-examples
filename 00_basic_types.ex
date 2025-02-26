# Basic types in Elixir

1          # integer
0x1F       # integer
1.0        # float
true       # boolean
:atom      # atom / symbol
"elixir"   # string

# Basic arithmetic
1 + 1 # => 2
1 - 1 # => 0
1 * 1 # => 1
1 / 1 # => 1.0

# / always returns a float

div(10, 2) # => 5
rem(10, 3) # => 1

# Elixir allows to drop parentheses for functions

div 10, 2 # => 5

# Floats can be expressed in decimal or scientific notation

1.0 # => 1.0
1.0e-10 # => 1.0e-10

# 1.0e-10 is the same as 1.0 * 10^-10
1.0e-10 == 1.0 * 10**(-10) # => true

# round and trunc are used to convert floats to integers

round(3.56) # => 4
round(3.46) # => 3

trunc(3.56) # => 3
trunc(3.46) # => 3

# is_integer and is_float are used to check the type of a value

is_integer(1) # => true
is_integer(1.0) # => false

is_float(1) # => false
is_float(1.0) # => true

# Elixir provides three boolean operators: or, and and not:

true or false # => true
true and false # => false
not true # => false

# Elixir is a strict language in most cases, so:
1 and true
# => ** (BadBooleanError) ...

# or and and are short-circuited, which means that they will not evaluate the
# second argument if the result is already known.

true or raise("This will not be evaluated") # => true
false and raise("This will not be evaluated") # => false

# nil represents the absence of a value
# Operators ||, && and ! can be used to handle nil values.
# These operators consider nil and false as "falsy", and everything else as "truthy".

1 || true # => 1
false || 11 # => 11

nil && 13 # => nil
true && 13 # => 13

!true # => false
!1 # => false
!nil # => true

# Values like 0 or "", or [] are truthy in Elixir

# An atom is a constant symbolic value which evaluates to itself.

:apple # => :apple
:orange # => :orange
:watermelon # => :watermelon

:apple == :apple # => true
:apple == :orange # => false

# true and false are atoms

true == :true # => true
false == :false # => true

i true
# =>
# Term
#   true
# Data type
#   Atom
# Reference modules
#   Atom
# Implemented protocols
#   IEx.Info, Inspect, List.Chars, String.Chars

is_boolean(false) # => true
is_atom(false) # => true

# Strings are sequences of characters, they are enclosed in double quotes

"elixir" # => "elixir"

# Strings can be concatenated with the <> operator

"hello" <> " world" # => "hello world"

# Strings can be interpolated:

name = "Peter"

"hello #{name}" # => "hello Peter"

# String manipulation functions are in String module

String.length("hello") # => 5
String.split("hello world", " ") # => ["hello", "world"]
String.replace("hello world", "world", "Elixir") # => "hello Elixir"

# == is used to compare values

1 == 1 # => true
1 == 2 # => false

# === is used to compare values and types

1 === 1 # => true
1 === 1.0 # => false
