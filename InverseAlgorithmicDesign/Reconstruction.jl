# export reconstruct

import Statistics

include("Types.jl")
include("ReconstructionTypes.jl")

## Run reconstruction

# Opções:
# Criar N bins e usar isso para os pontos, efetivamente transforma o espaço contínuo num grid-world

# Utilizar algo mais parecido com clustering, provavelmente pode criar clusters demasiado compridos caso tenha muitos pontos próximos. Este método está de fora.
# É capaz de haver métodos que não sofrem desse problema (metodos hierarquicos possivelmente).

# Pegar num ponto: escolher todos os que estejam perto o suficiente, simplesmente não passar pelos outros quando seguirmos em frente

# 1º método

# 3º método
"""
    cluster_generic(values, criteria)

Groups the values in `values` by criteria. The function works greedily,
therefore, clustering is not optimal. For each value in sorted `values`,
other values that meet `criteria` are given the
same group. Values which have been grouped before are skipped.

Returns three Dicts:
1 => Returns an index, given a value;
2 => Returns the list of values corresponding to the index;

# Examples
```julia-repl
julia> cluster_generic([1, 1.4, 2, 1.4], (x,y) -> abs(x - y) <= 0.5)
(Dict(1.4 => 1, 2.0 => 2, 1.0 => 1), Dict(2 => [2.0], 1 => [1.0, 1.4, 1.4]))
```
"""
function cluster_generic(values::Vector{T}, criteria::Function)::Tuple{Dict{T,Index},Dict{Index,Vector{T}}} where {T}
    values = sort(values)
    valuetoindex = Dict()
    indextovalue = Dict()
    indicesassigned = Set()

    currentidx = 1
    for (i1, x1) in enumerate(values)
        if i1 in indicesassigned
            continue
        end

        valuetoindex[x1] = currentidx
        indextovalue[currentidx] = [x1]
        push!(indicesassigned, i1)

        for (i2, x2) in enumerate(values)
            if i2 in indicesassigned # i1 == i2 is redundant because i1 is pushed before
                continue
            end

            if criteria(x1, x2)
                valuetoindex[x2] = currentidx
                push!(indextovalue[currentidx], x2)
                push!(indicesassigned, i2)
            end
        end

        currentidx += 1
    end

    return valuetoindex, indextovalue
end

function cluster_values(values::Vector{Float64}, distancethreshold)::Tuple{Dict{Float64,Index},Dict{Index,Vector{Float64}}}
    return cluster_generic(
        values,
        (x, y) -> abs(x - y) <= distancethreshold)
end

function cluster_values(values::Vector{XY}, distancethreshold)::Tuple{Dict{XY,Index},Dict{Index,Vector{XY}}}
    return cluster_generic(
        values,
        (p1, p2) -> (p1.x - p2.x)^2 + (p1.y - p2.y)^2 ≤ distancethreshold^2)
end

function cluster_values(values::Vector{IndexTuple})::Tuple{Dict{IndexTuple,Int64},Dict{Index,IndexTuple}}
    valuetoindex, indextovalue = cluster_generic(
        values,
        (t1, t2) -> t1 == t2
    )
    indicesonly = Dict(idx => value[1] for (idx, value) in indextovalue)
    return valuetoindex, indicesonly
end


"""
    average_cluster(clusters)

Converts a Dict of index=>values to index=>mean(values).

# Example
```julia-repl
julia> average_cluster(Dict(1=>[1, 1.4], 2=>[5]))
(Dict(1 => 1.2, 2 => 5.0), Dict(1.2 => 1, 5.0 => 1))
```
"""
function average_cluster(clusters::Dict{Index,Vector{Float64}})::Tuple{Dict{Float64,Index},Dict{Index,Float64}}
    averagestoindex = Dict(Statistics.mean(j) => i for (i, j) in clusters)
    indextoaverages = Dict(i => Statistics.mean(j) for (i, j) in clusters)

    return averagestoindex, indextoaverages
end


function reconstruct(elements; distancethreshold = 1.0)
    allpoints = [([[w.p, w.q] for w in elements.walls]...)...]
    allx = map(p -> p.x, allpoints)
    ally = map(p -> p.y, allpoints)

    # value -> index, index -> value
    xclusters = cluster_values(allx, distancethreshold)
    xaverages = average_cluster(xclusters[2])

    yclusters = cluster_values(ally, distancethreshold)
    yaverages = average_cluster(yclusters[2])

    indexed_points = map(p -> (xclusters[1][p.x], yclusters[1][p.y]), allpoints)
    pclusters = cluster_values(indexed_points)

    walls = [AdjustedWall(w, xclusters[1], xaverages[2], yclusters[1], yaverages[2]) for w in elements.walls]
    indexed_walls = [IndexedWall(w, xaverages[1], yaverages[1], pclusters[1]) for w in walls]

    return (xvalues = xaverages[2], yvalues = yaverages[2], points = pclusters[2], walls = indexed_walls)
end
