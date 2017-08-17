require_relative "heap"
require "byebug"

class Array
  def heap_sort!
    # idx = 0
    # array = BinaryMinHeap.new
    # while idx < self.length
    #   p 'the array'
    #   p self
    #   BinaryMinHeap.heapify_up(self, idx) {|x,y| x <=> y }
    #   idx += 1
    # end
    # j = 0
    # last_idx = self.length-1
    # while last_idx > 0
    #   self[0],self[last_idx] = self[last_idx], self[0]
    #   last_idx -= 1
    #   BinaryMinHeap.heapify_down(self[0..last_idx], 0)
    # end
    heaped = BinaryMinHeap.new
    self.each do |el|
      p 'heap'
      p heaped
      heaped.push(el)
    end
    newArr = []
    until heaped.count == 0
      newArr.push(heaped.extract)
    end
    p newArr
    self.replace(newArr)
  end
end
