require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count+1 == num_buckets
    unless include?(key)
      self[key].push(key)
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    oldStore = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    oldStore.each do |arr|
      arr.each do |el|
        @store[el].push(el)
      end
    end
  end
end
