import Statistics
using Distances
using Clustering

include("Types.jl")
include("ReconstructionTypes.jl")

function mean_cluster(clusters::Dict{Index,Vector{Float64}})::Tuple{Dict{Float64,Index},Dict{Index,Float64}}
    meanstoindex = Dict(Statistics.mean(j) => i for (i, j) in clusters)
    indextomean = Dict(i => Statistics.mean(j) for (i, j) in clusters)

    return meanstoindex, indextomean
end

function median_cluster(clusters::Dict{Index,Vector{Float64}})::Tuple{Dict{Float64,Index},Dict{Index,Float64}}
    medianstoindex = Dict(Statistics.median(j) => i for (i, j) in clusters)
    indextomedian = Dict(i => Statistics.median(j) for (i, j) in clusters)

    return medianstoindex, indextomedian
end

function hcluster(values::Vector{<:Real}, distancethreshold)
    values = sort(values)
    D = pairwise(Euclidean(), values'; dims=2)
    clusters = cutree(hclust(D, linkage=:complete); h=distancethreshold)

    valuetoindex = Dict(values[i] => clusters[i] for i in 1:length(values))
    indextovalues = Dict(i => values[clusters.==i] for i in unique(clusters))
    return valuetoindex, indextovalues
end

function hcluster(values::Vector{XY}, distancethreshold)
    values = sort(values)
    D = pairwise(Euclidean(), [[p.x, p.y] for p in values])
    clusters = cutree(hclust(D, linkage=:complete); h=distancethreshold)

    valuetoindex = Dict(values[i] => clusters[i] for i in 1:length(values))
    indextovalues = Dict(i => values[clusters.==i] for i in unique(clusters))
    return valuetoindex, indextovalues
end

function hcluster(values::Vector{IndexTuple})
    values = sort(values)
    D = pairwise(Euclidean(), values)
    clusters = cutree(hclust(D, linkage=:complete); h=0)

    valuetoindex = Dict(values[i] => clusters[i] for i in 1:length(values))
    indextovalues = Dict(i => values[clusters.==i][1] for i in unique(clusters))
    return valuetoindex, indextovalues
end

function reconstruct_wall_points(walls, distance_threshold=1.0)
    allpoints = [([[w.p, w.q] for w in elements.walls]...)...]
    allx = map(p -> p.x, allpoints)
    ally = map(p -> p.y, allpoints)

    # value -> index, index -> value
    xclusters = hcluster(allx, distancethreshold)
    xaverages = mean_cluster(xclusters[2])

    yclusters = hcluster(ally, distancethreshold)
    yaverages = mean_cluster(yclusters[2])

    indexed_points = map(p -> (xclusters[1][p.x], yclusters[1][p.y]), allpoints)
    pclusters = hcluster(indexed_points)

    return xclusters, xaverages, yclusters, yaverages, pclusters
end

function reconstruct_element_scalars(elements; distancethreshold = 0.1)
    allthicknesses = [([w.thickness for w in elements.walls]...)...]
    tclusters = hcluster()
end

function reconstruct(elements; distancethreshold=1.0)
    xclusters, xaverages, yclusters, yaverages, pclusters = reconstruct_wall_points(elements.walls; distancethreshold=distancethreshold)

    walls = [AdjustedWall(w, xclusters[1], xaverages[2], yclusters[1], yaverages[2]) for w in elements.walls]
    indexed_walls = [IndexedWall(w, xaverages[1], yaverages[1], pclusters[1]) for w in walls]

    return (xvalues=xaverages[2], yvalues=yaverages[2], points=pclusters[2], walls=indexed_walls)
end
