class Vertex
  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
    @visited = false
  end

  attr_accessor :value, :in_edges, :out_edges, :visited

end

class Edge
  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @from_vertex.out_edges.push(self)
    @to_vertex = to_vertex
    @to_vertex.in_edges.push(self)
    @cost = cost
  end

  attr_accessor :from_vertex, :to_vertex, :cost

  def destroy!
    @from_vertex.out_edges.delete(self)
    @from_vertex = nil
    @to_vertex.in_edges.delete(self)
    @to_vertex = nil
  end
end
