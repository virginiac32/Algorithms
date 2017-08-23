# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require 'byebug'
require_relative 'graph'
# require_relative 'topo_sort'


def install_order(arr)
  # debugger
  vertex_vals = []
  arr.each do |el|
    vertex_vals.push(el[0])
    vertex_vals.push(el[1])
  end
  vertex_vals = vertex_vals.uniq
  max = arr.max{|el| el[0]}
  (1..max[0]).each do |el|
    unless vertex_vals.include?(el)
      vertex_vals.push(el)
    end
  end
  vertices = []
  vertex_vals.each do |val|
    vertices.push(Vertex.new(val))
  end
  # debugger
  vertices.each do |vertex|
    arr.each do |el|
      if vertex.value == el[1]
        to_v = vertices.find_all{|vertex| vertex.value == el[0]}
        Edge.new(vertex,to_v[0])
      end
    end
  end
  # debugger
  sorted = topo_sort(vertices)
  values = []

  sorted.each do |vertex|
    values.push(vertex.value)
  end
  return values
end


def topo_sort(vertices)
  # debugger
  stack = []
  cyclic_stack = []
  vertices.each do |vertex|
    unless vertex.visited
      topological_helper(vertex,stack,cyclic_stack)
    end
  end
  stack.reverse
end

def topological_helper(vertex,stack,cyclic_stack)
  vertex.visited = true
  vertex.out_edges.each do |edge|
    unless edge.to_vertex.visited
      topological_helper(edge.to_vertex,stack,cyclic_stack)
    end
  end
  all_visited = vertex.in_edges.all? do |edge|
    edge.from_vertex.visited
  end
  if all_visited
    cyclic_stack.push(vertex)
  end
  stack.push(vertex)
end


  # result = []
  # packages = []
  # max = arr.max{|el| el[0]}
  # dependent_packages = []
  # arr.each do |el|
  #   dependent_packages.push(el[0])
  # end
  # (1..max[0]).each do |el|
  #   unless dependent_packages.include?(el)
  #     packages.push(el)
  #   end
  # end
  # until arr.empty?
  #   arr.each do |el|
  #     if packages.include?(el[1])
  #       result.push(el)
  #       packages.push(el[0])
  #     end
  #     arr.delete(el)
  #   end
  # end
  # result
