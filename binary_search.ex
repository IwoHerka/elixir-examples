
defmodule Search do
  def binary_search(sorted_tuple, target) do
    do_search(sorted_tuple, target, 0, tuple_size(sorted_tuple) - 1)
  end

  defp do_search(sorted_tuple, target, low, high) do
    mid = div(low + high, 2)
    mid_value = elem(sorted_tuple, mid)

    cond do
      mid_value == target -> mid

      mid_value < target ->
        do_search(sorted_tuple, target, mid + 1, high)

      mid_value > target ->
        do_search(sorted_tuple, target, low, mid - 1)
    end
  end
end
