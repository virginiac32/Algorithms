# Write an in place method that finds the kth smallest element in O(n) time.
# You'll want to use a partition method similar to the QuickSort one.
# Also, how can we eliminate any extra space cost?. 1st smallest is the
# 0th element in a sorted array

class Array

  def self.partition(array, start, length, &prc)

  end

  def select_kth_smallest(k)
    left = 0
    right = self.length-1
    while true
      return self[left] if left == right
      pivot_idx = Array.partition(self, left, right-left+1)
      if k-1 == pivot_idx
        return self[k-1]
      elsif k-1 < pivot_idx
        right = pivot_idx-1
      else
        left = pivot_idx+1
      end
  end
end

arr = [1,4,2,5,3,5]
p arr.select_kth_smallest(1)
p arr.select_kth_smallest(2)
p arr.select_kth_smallest(3)
p arr.select_kth_smallest(4)
p arr.select_kth_smallest(5)
p arr.select_kth_smallest(6)
