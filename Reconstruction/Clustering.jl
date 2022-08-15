using Distances
using Clustering

include("Types.jl")

function mean_cluster(clusters::Dict{Index,Vector{Float64}})::Dict{Index,Float64}
    return Dict(i => Statistics.mean(j) for (i, j) in clusters)
end

function median_cluster(clusters::Dict{Index,Vector{Float64}})::Dict{Index,Float64}
    return Dict(i => Statistics.median(j) for (i, j) in clusters)
end

function hcluster(values::Vector{<:Real}, distancethreshold, nclusters=nothing)
    values = sort(values)
    D = pairwise(Euclidean(), values'; dims=2)

    clusters = nclusters === nothing ?
               cutree(hclust(D, linkage=:complete); h=distancethreshold) :
               cutree(hclust(D, linkage=:complete); k=nclusters)

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