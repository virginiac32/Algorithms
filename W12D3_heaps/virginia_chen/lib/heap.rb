class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc
    unless prc
      @prc = Proc.new{ |x,y| x <=> y }
    end
    @store = []

  end

  def count
    @store.length
  end

  def extract
    extracted = @store[0]
    @store[0] = @store[count-1]
    @store.pop
    self.class.heapify_down(@store, 0)
    extracted
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(@store, @store.length-1)
  end

  public
  def self.child_indices(len, parent_index)
    children = []
    if 2*(parent_index)+ 1 < len
      children.push(2*(parent_index)+ 1)
    end
    if 2*(parent_index)+ 2 < len
      children.push(2*(parent_index)+ 2)
    end
    children
  end

  def self.parent_index(child_index)
    if child_index == 0
      raise "root has no parent"
    else
      (child_index - 1)/2
    end
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc = Proc.new{ |x,y| x <=> y }
    children_indices = self.child_indices(len, parent_idx)
    min_child_idx = children_indices.min { |idx| array[idx]}
    if min_child_idx
      if prc.call(array[parent_idx],array[min_child_idx]) > 0
        array[parent_idx], array[min_child_idx] = array[min_child_idx], array[parent_idx]
        self.heapify_down(array, min_child_idx, len = array.length, &prc)
      end
    else
      return array
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new{ |x,y| x <=> y }
    if child_idx > 0
      parent_idx = self.parent_index(child_idx)
      if prc.call(array[child_idx],array[parent_idx]) < 0
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        self.heapify_up(array,parent_idx,len = array.length, &prc)
      end
    else
      return array
    end
  end
end
