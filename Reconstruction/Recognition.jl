export recognize

import Conda
import ImageMagick
using PyCall

include("Types.jl")
include("Clustering.jl")

function fix_coordinates(elements, scaledetection, file;
    scalefactor=0.1,
    realwidth=30
)
    adjust = nothing
    factor = nothing
    width, height = ImageMagick.metadata(file)[1]

    factor = 1
    if scaledetection === :none
        return elements
    elseif scaledetection === :factor
        factor = scalefactor
    elseif scaledetection === :width
        factor = realwidth / width
    elseif scaledetection === :walls
        allthicknesses = [([w.thickness for w in elements.walls]...)...]
        tclusters = hcluster(sort(allthicknesses), nothing, 2)
        medianthickwall = median_cluster(tclusters[2])[2]
        factor = 0.3 / medianthickwall # assuming 0.3m for thick walls
    end
    adjust = (p::XY) -> XY(p.x, height - p.y) * factor

    for wall in elements.walls
        wall.p, wall.q = adjust(wall.p), adjust(wall.q)
        wall.thickness *= factor
        for el in wall.elements
            el.p, el.q = adjust(el.p), adjust(el.q)
        end
    end
    for railing in elements.railings
        railing.p, railing.q = adjust(railing.p), adjust(railing.q)
        railing.thickness *= factor
    end

    for symbol in elements.symbols
        symbol["points"][:,2] = height .- symbol["points"][:,2]
        symbol["points"] *= factor
    end

    return elements
end

function segment_from_door(door::LineSegment)
    width = 0.2
    halfwidth = width / 2

    c = center(door)
    normal = perpendicular(vector(door))

    return LineSegment(c - normal * halfwidth, c + normal * halfwidth)
end

function recognize(file, scaledetection; forceinstall=false)
    recognitionpath = joinpath(@__DIR__, "../Recognition/")

    if !isfile(file)
        error("No such file: $file")
    end

    if forceinstall || !isfile(".pipinstalled")
        Conda.pip_interop(true)
        Conda.pip("install", ["-r", joinpath(recognitionpath, "requirements.txt")])
        touch(".pipinstalled")
    end

    py"""
    import sys
    sys.path.insert(1, $recognitionpath)
    """

    # add to rename "recognition" to "test" for some reason
    recognition = pyimport("recognition").main
    results_raw = recognition(file, "brute_force", verbose=true, save_results=false)

    # results = fixcoordinates(results_raw)
    results = (
        walls=[Wall(w) for w in results_raw["walls"]],
        railings=[Railing(r) for r in results_raw["railings"]],
        symbols=results_raw["symbols"]
    )

    return fix_coordinates(results, scaledetection, file)
end
