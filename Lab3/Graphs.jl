module Graphs

using StatsBase

export GraphVertex, NodeType, Person, Address,
       generate_random_graph, get_random_person, get_random_address, generate_random_nodes,
       convert_to_graph,
       bfs, check_euler, partition,
       graph_to_str, node_to_str,
       test_graph

#= Single graph vertex type.
Holds node value and information about adjacent vertices =#
mutable struct GraphVertex
  value::Any
  neighbors::Vector
end

# Types of valid graph node's values.
abstract type NodeType end

mutable struct Person <: NodeType
  name::String
end

mutable struct Address <: NodeType
  streetNumber::Int8
end


# Number of graph nodes.
const N = 800

# Number of graph edges.
const K = 10000


#= Generates random directed graph of size N with K edges
and returns its adjacency matrix.=#
# To be filled with 0 bitmap
function generate_random_graph()::BitArray
    A = falses(N, N)

    for i in sample(1:N*N, K, replace=false)
      row, col = ind2sub(size(A), i)
      A[row,col] = 1
      A[col,row] = 1
    end
    A
end


# Generates random person object (with random name).
function get_random_person()::Person
  Person(randstring())
end

# Generates random person object (with random name).
function get_random_address():Address
  Address(rand(1:100))
end

# Generates N random nodes (of random NodeType).
function generate_random_nodes()
  #https://lectures.quantecon.org/jl/julia_arrays.html#array-vs-vector-vs-matrix
  nodes = Vector{NodeType}()
  for i= 1:N
    push!(nodes, rand() > 0.5 ? get_random_person() : get_random_address())
  end
  nodes
end

#= Converts given adjacency matrix (NxN)
  into list of graph vertices (of type GraphVertex and length N). =#
function convert_to_graph(A::BitArray, nodes::Array{Graphs.NodeType,1},
    graph::Array{GraphVertex,1})
  #N = length(nodes)
  #Duplicate since N is known
  push!(graph, map(n -> GraphVertex(n, GraphVertex[]), nodes)...)

  for i = 1:N, j = 1:N
      if A[i,j]
        push!(graph[i].neighbors, graph[j])
      end
  end
end

#= Groups graph nodes into connected parts. E.g. if entire graph is connected,
  result list will contain only one part with all nodes. =#
function partition(graph::Array{GraphVertex, 1})::Array{Set{Graphs.GraphVertex},1}
  parts = []
  remaining = Set(graph)
  visited = bfs(remaining=remaining)
  push!(parts, Set(visited))
  while !isempty(remaining)
    new_visited = bfs(visited=visited, remaining=remaining)
    push!(parts, new_visited)
  end
  parts
end

#= Performs BFS traversal on the graph and returns list of visited nodes.
  Optionally, BFS can initialized with set of skipped and remaining nodes.
  Start nodes is taken from the set of remaining elements. =#

function bfs(;visited::Set=Set(), remaining::Set=Set(graph))::Set{Graphs.GraphVertex}

  first = next(remaining, start(remaining))[1]
  q = [first]
  push!(visited, first)
  delete!(remaining, first)
  local_visited = Set([first])
  while !isempty(q)
    v = pop!(q)

  for n in v.neighbors
    if !(n in visited)
      push!(q, n)
        push!(visited, n)
        push!(local_visited, n)
        delete!(remaining, n)
        end
      end
    end
  local_visited
end

#= Checks if there's Euler cycle in the graph by investigating
   connectivity condition and evaluating if every vertex has even degree =#
function check_euler(graph::Array{GraphVertex,1})::Bool
  if length(partition(graph)) == 1
    return all(map(v -> iseven(length(v.neighbors)), graph))
  end
    false
end

node_to_str(n::Person)::String = "Person: $(n.name)\n"
node_to_str(n::Address)::String = "Street nr: $(n.streetNumber)\n"

#= Returns text representation of the graph consisiting of each node's value
   text and number of its neighbors. =#
function graph_to_str(graph::Array{GraphVertex, 1})::IOBuffer
  io_buff = IOBuffer()

  for v in graph
    write(io_buff,"****\n")

    write(io_buff,node_to_str(v.value))

    write(io_buff,"Neighbors: $(length(v.neighbors))\n")
  end
  io_buff
end

#= Tests graph functions by creating 100 graphs, checking Euler cycle
  and creating text representation. =#
function test_graph()
  io_buff = IOBuffer()
  for i=1:100

    graph = GraphVertex[]

    A::BitArray= generate_random_graph()
    nodes = generate_random_nodes()
    convert_to_graph(A, nodes, graph)

    big_io_buff::IOBuffer = graph_to_str(graph)
    #println(String(take!(big_io_buff)))
    write(io_buff,check_euler(graph) ? "True \n":"False \n")
  end
  println(String(take!(io_buff)))
end

end
