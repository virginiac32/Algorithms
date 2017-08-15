# def single_in_sorted(arr)
#   return nil if arr.size == 0
#   mid = arr.size/2
#
#   case self[mid] <=> target
#   when 0
#     return mid
#   when 1
#     return self.dup.take(mid).my_bsearch(target)
#   else
#     search_res = self.dup.drop(mid+1).my_bsearch(target)
#     search_res.nil? ? nil : mid + 1 + search_res
#   end
# end

def single_in_sorted(arr)
  low = 0
  hi = arr.length - 1
  while low < hi
    mid = ((hi - low) / 2)
    return arr[mid] if arr[mid] != arr[mid-1] && arr[mid] != arr[mid+1]
    if (arr[mid] == arr[mid-1] && mid.odd?) ||
      (arr[mid] == arr[mid+1] && mid.even?)
      low = mid + 1
    else
      hi = mid - 1
    end
  end
  arr[low]
end
