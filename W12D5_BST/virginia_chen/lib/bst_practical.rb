
def kth_largest(tree_node, k)
  array = in_oppo_order_traversal(tree_node,[])
  return array[k-1]
end


def in_oppo_order_traversal(tree_node = @root, arr = [])
  if tree_node.left == nil && tree_node.right == nil
    arr = [tree_node]
    return arr
  end
  if tree_node.left
    left = in_oppo_order_traversal(tree_node.left,arr)
  else
    left = []
  end
  if tree_node.right
    right = in_oppo_order_traversal(tree_node.right,arr)
  else
    right = []
  end
  return right.push(tree_node).push(left).flatten

end
