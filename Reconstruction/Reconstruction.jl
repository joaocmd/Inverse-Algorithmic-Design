import Statistics

include("Types.jl")
include("ReconstructionTypes.jl")
include("Clustering.jl")

function reconstruct_wall_points(walls, railings; distancethreshold=1.0)
    allpoints = [([[w.p, w.q] for w in [walls..., railings...]]...)...]
    allx = map(p -> p.x, allpoints)
    ally = map(p -> p.y, allpoints)

    # value -> index, index -> value
    xclusters = hcluster(allx, distancethreshold)
    xaverages = mean_cluster(xclusters[2])

    yclusters = hcluster(ally, distancethreshold)
    yaverages = mean_cluster(yclusters[2])

    indexed_points = map(p -> (xclusters[1][p.x], yclusters[1][p.y]), allpoints)
    pclusters = hcluster(indexed_points)

    return xclusters[1], xaverages, yclusters[1], yaverages, pclusters[1], pclusters[2]
end

function reconstruct_element_scalars(walls, railings;
    thicknessthreshold=nothing,
    thicknessclusters=2,
    widththreshold=0.1,
    widthclusters=nothing
)
    allthicknesses = [w.thickness for w in walls]
    tclusters = hcluster(sort(allthicknesses), thicknessthreshold, thicknessclusters)
    taverages = median_cluster(tclusters[2])

    railingthickness = length(railings) > 0 ? Statistics.mean([r.thickness for r in railings]) : nothing

    wallelements = [([w.elements for w in walls]...)...]

    doors = [e for e in wallelements if e isa Door]
    doorwidths = [length(d) for d in doors]
    dclusters = hcluster(sort(doorwidths), widththreshold, widthclusters)
    daverages = median_cluster(dclusters[2])

    windows = [e for e in wallelements if e isa Window]
    windowwidths = [length(w) for w in windows]
    wclusters = hcluster(sort(windowwidths), widththreshold, widthclusters)
    waverages = median_cluster(wclusters[2])

    return tclusters[1], taverages, dclusters[1], daverages, wclusters[1], waverages, railingthickness
end

function reconstruct_symbol(element)
    if element["type"] == "toilet"
        return Toilet(element)
    elseif element["type"] == "sink"
        return Sink(element)
    elseif element["type"] == "closet"
        return Closet(element)
    else
        return element
    end
end

function reconstruct(elements; maxpointdistance=1.0)
    xclusters, xaverages, yclusters, yaverages, pclusters, pvalues = reconstruct_wall_points(elements.walls, elements.railings; distancethreshold=maxpointdistance)

    # filter walls and railings with p != q
    walls = filter(w -> length(unique(adjust_to_clusters(w.p, w.q, xclusters, yclusters))) == 2, elements.walls)
    railings = filter(r -> length(unique(adjust_to_clusters(r.p, r.q, xclusters, yclusters))) == 2, elements.railings)

    tclusters, taverages, dclusters, daverages, wclusters, waverages, railingthickness = reconstruct_element_scalars(walls, railings)

    indexedwalls = [
        IndexedWall(w,
            xclusters, xaverages, yclusters, yaverages, pclusters,
            tclusters, dclusters, wclusters)
        for w in walls
    ]

    indexedrailings = [
        IndexedRailing(r, xclusters, yclusters, pclusters) for r in railings
    ]

    return (
        xvalues=xaverages, yvalues=yaverages, points=pvalues,
        walls=indexedwalls,
        railings=indexedrailings,
        tvalues=taverages, dvalues=daverages, wvalues=waverages,
        railingthickness=railingthickness,
        symbols=[reconstruct_symbol(s) for s in elements.symbols]
    )
end
