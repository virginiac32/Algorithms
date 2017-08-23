require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

# def topological_sort(vertices)
#   stack = []
#   cyclic_stack = []
#   vertices.each do |vertex|
#     unless vertex.visited
#       topo_helper(vertex,stack,cyclic_stack)
#     end
#   end
#   stack.reverse
# end
#
# def topo_helper(vertex,stack,cyclic_stack)
#   vertex.visited = true
#   vertex.out_edges.each do |edge|
#     unless edge.to_vertex.visited
#       topo_helper(edge.to_vertex,stack,cyclic_stack)
#     end
#   end
#   p vertex
#   all_visited = vertex.in_edges.all? do |edge|
#     p edge
#     edge.from_vertex.visited
#   end
#   p 'allvisited'
#   p all_visited
#
#   if all_visited
#     cyclic_stack.push(vertex)
#   end
#   stack.push(vertex)
# end


# Khan's version
def topological_sort(vertices)
  sorted = []
  top = []
  all_vertices = vertices
  all_vertices.each do |vertex|
    if vertex.in_edges.empty?
      top.push(vertex)
    end
  end
  until top.empty?
    current = top.shift
    sorted << current
    current.out_edges.each do |edge|
      # if edge.to_vertex.in_edges.length == 1
      #   top.push(edge.to_vertex)
      # end
      edge.destroy!
    end
    # current = nil
  end
  if sorted.length != vertices.length
    return []
  else
    return sorted
  end
end
