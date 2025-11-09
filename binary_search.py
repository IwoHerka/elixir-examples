
class Search:
  @staticmethod
  def binary_search_iterative(sorted_list, target):
    low = 0
    high = len(sorted_list) - 1

    while low <= high:
      mid = (low + high) // 2
      mid_value = sorted_list[mid]

      if mid_value == target:
        return mid
      elif mid_value < target:
        low = mid + 1
      else:
        high = mid - 1

    return -1