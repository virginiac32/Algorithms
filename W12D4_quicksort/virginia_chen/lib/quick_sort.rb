require 'byebug'

class QuickSort

  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return if array.length <= 2
    pivot = array[0]
    left = []
    right = []
    array.each do |el|
      if el <= pivot
        left.push(el)
      else
        right.push(el)
      end
    end
    return self.sort1(left).concat(pivot).concat(self.sort1(right))
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new{ | a,b | a <=> b }

    return array if length <= 1
    # debugger
    pivot = QuickSort.partition(array,start,length, &prc)
    QuickSort.sort2!(array,start,pivot-start, &prc)
    QuickSort.sort2!(array,pivot+1,length-pivot-1+start, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x,y| x <=> y }
    return if length <=1
    partition = start+1
    ((start+1)..(start+length-1)).each do |i|
      # debugger
      if prc.call(array[i],array[start]) < 0
        array[i],array[partition] = array[partition],array[i]
        partition += 1
      end
    end
    array[partition-1], array[start] = array[start], array[partition-1]
    partition-1
  end

end
