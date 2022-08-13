export recognize

import Conda
using PyCall
include("Types.jl")

const scale_factor = 0.1

function change_coordinates(p::XY)::XY
    return XY(p.x, 255 - p.y) * scale_factor
end

function fix_coordinates(elements)
    for wall in elements.walls
        wall.p, wall.q = change_coordinates(wall.p), change_coordinates(wall.q)
        wall.thickness *= scale_factor
        for el in wall.elements
            el.p, el.q = change_coordinates(el.p), change_coordinates(el.q)
        end
    end

    # for symbol in symbols
    # end
    return elements
end

function segment_from_door(door::LineSegment)
    width = 0.2
    halfwidth = width / 2

    c = center(door)
    normal = perpendicular(vector(door))

    return LineSegment(c - normal * halfwidth, c + normal * halfwidth)
end

function recognize(file; forceinstall=false)
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
        symbols=results_raw["symbols"]
    )

    return fix_coordinates(results)
end
