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

function reconstruct_wall_points(walls; distancethreshold=1.0)
    allpoints = [([[w.p, w.q] for w in walls]...)...]
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

function reconstruct_element_scalars(walls; thicknessthreshold=1, widththreshold=0.2)
    allthicknesses = [([w.thickness for w in walls]...)...]
    tclusters = hcluster(sort(allthicknesses), thicknessthreshold)
    taverages = median_cluster(tclusters[2])

    wallelements = [([w.elements for w in walls]...)...]

    doors = [e for e in wallelements if e isa Door]
    doorwidths = [length(d) for d in doors]
    dclusters = hcluster(sort(doorwidths), widththreshold)
    daverages = median_cluster(dclusters[2])

    windows = [e for e in wallelements if e isa Window]
    windowwidths = [length(w) for w in windows]
    wclusters = hcluster(sort(windowwidths), widththreshold)
    waverages = median_cluster(wclusters[2])

    return tclusters, taverages, dclusters, daverages, wclusters, waverages
end

function reconstruct(elements; distancethreshold=1.0)
    xclusters, xaverages, yclusters, yaverages, pclusters = reconstruct_wall_points(elements.walls; distancethreshold=distancethreshold)
    tclusters, taverages, dclusters, daverages, wclusters, waverages = reconstruct_element_scalars(elements.walls)

    walls = [AdjustedWall(w, xclusters[1], xaverages[2], yclusters[1], yaverages[2]) for w in elements.walls]
    indexed_walls = [IndexedWall(w, xaverages[1], yaverages[1], pclusters[1]) for w in walls]

    return (xvalues=xaverages[2], yvalues=yaverages[2], points=pclusters[2], walls=indexed_walls)
end
