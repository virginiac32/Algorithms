require_relative 'heap'

def k_largest_elements(array, k)
  idx = 0
  array = BinaryMinHeap.new
  while idx < array.length
    BinaryMinHeap.heapify_up(array, idx) {|x,y| x <=> y }
    idx += 1
  end
  j = 0
  last_idx = array.length-1
  while last_idx > 0
    array[0],array[last_idx] = array[last_idx], array[0]
    last_idx -= 1
    BinaryMinHeap.heapify_down(array[0..last_idx], 0)
  end
  return array[0...k]
end
