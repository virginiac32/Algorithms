require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize(capacity = 8)
    @length = 0
    @capacity = capacity
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    if check_index(index)
      raise 'index out of bounds'
    else
      @store[index]
    end

  end

  # O(1)
  def []=(index, value)
    if check_index(index)
      raise "index out of bounds"
    else
      @store[index] = value
    end
  end

  # O(1)
  def pop
    if @length == 0
      raise 'index out of bounds'
    else
      @length = @length - 1
      popped = @store[@length]
      @store = @store[0...-1]
    end
    popped
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity
      resize!
    end
    @length += 1
    @store[@length-1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length == 0
      raise 'index out of bounds'
    else
      dup = StaticArray.new(@capacity)
      shifted = @store[0]
      @length.times do |idx|
        dup[idx] = @store[idx+1]
      end
      @length -= 1
      @store = dup
      shifted
    end
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @capacity == @length
      resize!
    end
    p 'old store'
    
    dup = StaticArray.new(@capacity)
    dup[0] = val
    i = 0
    while i < @length do
      dup[i+1] = @store[i]
      i+=1
    end
    @length += 1
    @store = dup
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    return true if index >= @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    copy = @store.dup
    @store = StaticArray.new(@capacity*2)
    @length.times do |idx|
      copy[idx] = @store[idx]
    end
    @store = copy
    @capacity = @capacity*2
  end
end
