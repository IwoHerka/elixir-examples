# -- Unicode --
# Unicode organizes all of the characters in its repertoire into code charts, and
# each character is given a unique numerical index. This numerical index is known
# as a Code Point.

# In Elixir you can use a ? in front of a character literal to reveal its code point:
?ł
# => 322
?a
# => 97


# We can represent any Unicode character in an Elixir string by using the \uXXXX
# notation and the hex representation of its code point number:
"hello \u0061" == "hello a"
# => true

घ ऒ	ओ	औ	क	ख, ą, ę, ć, ł, ...
# 11100000 10100100 10011000 ...

0x0061 == 97 == ?a
# => true

# -- UTF-8 --
# In UTF-8, each code point (which represents a character) can be expressed
# using one or more bytes.

# For example, for "hełło":
# 01101000 01100101 11000101 10000010 11000101 10000010 01101111

# 0xxxxxxx
# 110xxxxx
# 1110xxxx
# 11110xxx

# 1 byte: For code points in the ASCII range (U+0000 to U+007F), UTF-8 uses a single byte.
# 2 bytes: For code points from U+0080 to U+07FF, UTF-8 uses two bytes.
# 3 bytes: For code points from U+0800 to U+FFFF, UTF-8 uses three bytes.
# 4 bytes: For code points from U+10000 to U+10FFFF, UTF-8 uses four bytes.

# This variable-length encoding allows UTF-8 to efficiently represent a wide
# range of characters while remaining compatible with ASCII.


# -- Bitstrings --
# Bitstrings are sequences of bits, which can represent binary data or strings
# of characters.

IO.inspect("hełło", binaries: :as_binaries)
# => <<104, 101, 197, 130, 197, 130, 111>>

# In bitstring literal notation, we can specify the number of bits for each value:
<<0::1, 0::1, 1::1, 1::1>> == <<3::4>>
# It's the same as 0b0011

# -- Binary --
# A binary is a bitstring where the number of bits is divisible by 8.

is_bitstring(<<3::4>>)
# => true
is_binary(<<3::4>>)
# => false
is_bitstring(<<0, 255, 42>>)
# => true
is_binary(<<0, 255, 42>>)
# => true
is_binary(<<42::16>>)
# => true

IO.inspect("hełło", binaries: :as_binaries)
# => <<104, 101, 197, 130, 197, 130, 111>>
#      h   e     ł         ł         o

String.codepoints("hełło")
# => ["h", "e", "ł", "ł", "o"]

String.length("hełło")
# => 5

byte_size("hełło")
# => 7


# -- Charlists --
# A charlist is a sequence of characters, which is a sequence of code points:

String.to_charlist("hełło")
# => [104, 101, 322, 322, 111]

# Which is the same as:
[?h, ?e, ?ł, ?ł, ?o]

# -- Examples --

ł
# charlist [322]
# string "ł"
# codepoint:
#   binary 0b000101000010
#   hex 0x142
#   decimal 322
# UTF-8 11000101 10000010
# bitstring <<197, 130>>

11000101 10000010
