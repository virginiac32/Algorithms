class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.key == nil && @tail.key == nil
  end

  def get(key)
    if include?(key)
      node = @head
      until node.next == nil
        return node.val if node.key == key
        node = node.next
      end
    end
  end

  def getNode(key)
    if include?(key)
      node = @head
      until node.next == nil
        return node if node.key == key
        node = node.next
      end
    end
  end

  def include?(key)
    # each { |node| return true if node.key = key }
    # false
    node = @head
    until node.next == nil
      return true if node.key == key
      node = node.next
    end
    return false
  end

  def append(key, val)
    if @head.key == nil
      @head.key = key
      @head.val = val
    elsif @tail.key == nil
      @tail.key = key
      @tail.val = val
    else
      lastNode = @tail.prev
      newNode = Node.new(key,val)
      lastNode.next = newNode
      newNode.prev = lastNode
      newNode.next = @tail
      @tail.prev = newNode
    end
  end

  def update(key, val)
    if include?(key)
      thisNode = getNode(key)
      thisNode.val = val
    end
  end

  def remove(key)
    if include?(key)
      thisNode = getNode(key)
      if thisNode.prev
        prevNode = thisNode.prev
      else
        prevNode = nil
      end
      if thisNode.next
        nextNode = thisNode.next
      else
        nextNode = nil
      end
      prevNode.next = nextNode if prevNode
      nextNode.prev = prevNode if nextNode
    end
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end
