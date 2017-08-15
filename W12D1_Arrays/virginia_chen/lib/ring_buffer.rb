require_relative "static_array"
require 'byebug'

class RingBuffer
  attr_reader :length

  def initialize(capacity = 8)
    @capacity = capacity
    @start_idx = 0
    @store = StaticArray.new(@capacity)
    @length = 0
  end

  # O(1)
  def [](index)
    if check_index(index)
      raise 'index out of bounds'
    else
      @store[(@start_idx + index) % @capacity]
      # @store[index]
    end
  end

  # O(1)
  def []=(index, val)
    if check_index(index)
      raise "index out of bounds"
    else
      @store[(@start_idx + index) % @capacity] = val
      # @store[index] = val
    end
  end

  # O(1)
  def pop
    if @length == 0
      raise 'index out of bounds'
    else
      @length = @length - 1
      popped = @store[(@start_idx+@length) % @capacity]
      @store[(@start_idx+@length) % @capacity] = nil
      popped
    end

  end

  # O(1) ammortized
  def push(val)
    if @length == @capacity
      resize!
    end
    @length += 1
    @store[(@start_idx + @length-1) % @capacity] = val
  end

  # O(1)
  def shift
    if @length == 0
      raise 'index out of bounds'
    else
      shifted = @store[@start_idx]
      @store[@start_idx] = nil
      @length -= 1
      @start_idx = (@start_idx + 1) % @capacity
      return shifted
    end
    p 'what'
  end

  # O(1) ammortized
  def unshift(val)
    if @capacity == @length
      resize!
    end
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
    return @store
  end


  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  # returns true if out of bounds
  def check_index(index)
    return true if index >= @length
  end

  def resize!
    # copy = @store.dup
    copy = StaticArray.new(@capacity*2)
    p 'copy'
    p copy
    @length.times do |idx|
      # @store[idx] = copy[(@start_idx + idx + @capacity) % @capacity]
      # copy[idx] = self[idx]
      copy[idx] = @store[(@start_idx + idx) % @capacity]
    end
    p 'new copy'
    p copy

    @capacity = @capacity + @capacity
    p 'capacity'
    p @capacity
    @start_idx = 0
    @store = copy
  end
end
