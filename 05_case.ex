# case expression allows to compare a value against many patterns until we find
# a matching one. General form:

case expression do
  pattern1 -> expression1
  pattern2 -> expression2
  ...
  _ -> expression_default # Optional, acts as a default
end

# Example:

case {1, 2, 3} do
  {4, 5, 6} -> "Does not match"
  {1, x, 3} ->
    "This clause will match and bind x to 2, x = #{x}"
  _ ->
    "This clause would match any value"
end
# => "This clause will match and bind x to 2, x = 2"


# We can use pin operator to refer to the value being matched:
x = 1

case 10 do
  ^x ->
    "Won't match"
  y ->
    "Will match, x = #{y}"
end
# => "Will match, x = 10"


# Clauses allow for extra conditions using guards:
case {1, 2, 3} do
  {1, x, 3} when x > 0 ->
    "Will match"
  _ ->
    "Would match, if guard condition were different"
end
# => "Will match"


# Errors in guards are contained and do not interrupt the execution of the program:application
case 1 do
  x when hd(x) -> "Won't match"

  x -> "Got #{x}"
end


# Each branch can have multiple expressions, value of last one is returned:
case {:hello, "world"} do
  {:hello, _} ->
    x = 1
    y = 2
    x + y
  _ -> raise "Won't match"
end
# => 3
