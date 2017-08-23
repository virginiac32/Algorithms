require_relative 'bst_node'
require 'byebug'
# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  def initialize
    @root = nil
  end

  attr_accessor :root

  def insert(value)
    if @root == nil
      @root = BSTNode.new(value)
    else
      comparator = @root
      node = BSTNode.new(value)
      comparator = insertHelper(comparator,node)
      if node.value <= comparator.value
        comparator.left = node
      else
        comparator.right = node
      end
    end
  end

  def find(value, tree_node = @root)
    if value == tree_node.value
      return tree_node
    elsif value < tree_node.value && tree_node.left != nil
      find(value,tree_node.left)
    elsif value > tree_node.value && tree_node.right != nil
      find(value,tree_node.right)
    else
      return nil
    end
  end

  def delete(value)
    # debugger
    if @root == nil || (value == @root.value && @root.left == nil && @root.right == nil)
      @root = nil
      return nil
    end
    node = find(value)
    parent = find_parent(value)
    return nil if node == nil
    if node.left == nil && node.right == nil
      if parent.right == node
        parent.right = nil
      else
        parent.left = nil
      end
      node = nil
    elsif node.left == nil
      if parent
        if parent.right == node
          parent.right = node.right
        else
          parent.left = node.right
        end
      end
      node = node.right
    elsif node.right == nil
      if parent.right == node
        parent.right = node.left
      else
        parent.left = node.left
      end
      node = node.left
    else
      prev_max = max_parent(node.left)
      max = prev_max.right
      if max.left
        max_child = max.left
      end
      if parent.right == node
        parent.right = max

      else
        parent.left = max
      end
      node = max
      if max_child
        prev_max.right = max_child
      else
        prev_max.right = nil
      end

    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    until tree_node.right == nil
      prev_node = tree_node
      tree_node = tree_node.right
    end
    return tree_node
  end

  def max_parent(tree_node = @root)
    until tree_node.right == nil
      prev_node = tree_node
      tree_node = tree_node.right
    end
    return prev_node
  end

  def depth(tree_node = @root)
    if tree_node == nil
      return 0
    else
      if tree_node.right
        right = depth(tree_node.right)
      end
      if tree_node.left
        left = depth(tree_node.right)
      end
      if left == nil && right == nil
        return 0
      elsif left == nil
        return right+1
      elsif right == nil
        return left+1
      end
      if right > left
        return right+1
      else
        return left+1
      end
    end
  end

  def is_balanced?(tree_node = @root)
    if tree_node == nil
      return true
    end
    right_depth = 0
    left_depth = 0
    if tree_node.right
      right_depth = depth(tree_node.right)
    end
    if tree_node.left
      left_depth = depth(tree_node.left)
    end
    # if right_depth-left_depth > 1 || right_depth-left_depth < -1
    if right_depth != left_depth
      return false
    else
      is_balanced?(tree_node.right)
      is_balanced?(tree_node.left)
    end
    # return true
  end

  def in_order_traversal(tree_node = @root, arr = [])
    if tree_node.left == nil && tree_node.right == nil
      arr = [tree_node.value]
      return arr
    end
    if tree_node.left
      left = in_order_traversal(tree_node.left,arr)
    else
      left = []
    end
    if tree_node.right
      right = in_order_traversal(tree_node.right,arr)
    else
      right = []
    end
    return left.push(tree_node.value).push(right).flatten

  end

  # def traversal_helper(tree_node)
  #   left = tree_node.left
  # end

  def find_parent(value, tree_node = @root)
    node = find(value)
    parent = tree_node
    until parent.left == node || parent.right == node
      if value <= parent.value
        parent = parent.left
      else
        parent = parent.right
      end
    end
    return parent

    # if value == tree_node.left.value || value == tree_node.right.value
    #   return tree_node
    # elsif value < tree_node.left.value && tree_node.left.left != nil
    #   find(value,tree_node.left)
    # elsif value > tree_node.right.value && tree_node.right.right != nil
    #   find(value,tree_node.right)
    # else
    #   return nil
    # end
  end


  private
  # optional helper methods go here:

  def insertHelper(root,node)
    if node.value <= root.value
      if root.left == nil
        return root
      else
        insertHelper(root.left,node)
      end
    else
      if root.right == nil
        return root
      else
        insertHelper(root.right,node)
      end
    end
  end

end
