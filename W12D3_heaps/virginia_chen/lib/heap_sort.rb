require_relative "heap"
require "byebug"

class Array
  def heap_sort!
    sorted = true
    self[0...-1].each_with_index do |el,idx|
      if el > self[idx+1]
        sorted = false
      end
    end
    return self if sorted == true

    heaped = BinaryMinHeap.new
    self.each do |el|
      heaped.push(el)
    end
    newArr = []
    until heaped.count == 0
      newArr.push(heaped.extract)
    end
    self.replace(newArr)
  end
end
