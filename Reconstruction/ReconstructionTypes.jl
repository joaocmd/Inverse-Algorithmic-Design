using Statistics: mean

include("Types.jl")

order_points(p, q) = p < q ? (p, q) : (q, p)

abstract type BoxSymbol end

struct Closet <: BoxSymbol
    q::XY
    p::XY
end
Closet(element) = Closet(xy(element["points"][1,:]), xy(element["points"][3,:]))

abstract type OrientedSymbol end

struct Toilet <: OrientedSymbol
    c::XY
    angle::Int
end

Toilet(element) = Toilet(xy(mean(element["points"], dims=1)[1,:]), parse(Int, element["orientation"]))

struct Sink <: OrientedSymbol
    c::XY
    angle::Int
end

Sink(element) = Sink(xy(mean(element["points"], dims=1)[1,:]), parse(Int, element["orientation"]))

abstract type IndexedElement end

struct IndexedWall
    p::Index
    q::Index
    thickness::Index
    elements::Vector{IndexedElement}
end
Base.isless(w1::IndexedWall, w2::IndexedWall) = w1.p < w2.p || (w1.p == w2.p && w1.q < w2.q)

struct IndexedDoor <: IndexedElement
    p::Float64
    width::Index
    type::String
end

struct IndexedWindow <: IndexedElement
    p::Float64
    width::Index
end

function IndexedWall(wall, xclusters, xvalues, yclusters, yvalues, pclusters,
    tclusters, dclusters, wclusters)

    p, q = adjust_to_clusters(wall.p, wall.q, xclusters, yclusters)
    p, q = order_points(p, q)
    start = XY(xvalues[p[1]], yvalues[p[2]])
    elements = embed_elements(start, wall.elements, dclusters, wclusters)
    elements = sort(elements, by=(e) -> e.p)

    return IndexedWall(pclusters[p], pclusters[q], tclusters[wall.thickness], elements)
end

function adjust_to_clusters(p, q, xclusters, yclusters)
    p = (xclusters[p.x], yclusters[p.y])
    q = (xclusters[q.x], yclusters[q.y])

    return p, q
end

function embed_elements(startpoint, elements, dclusters, wclusters)
    function define_element(door::Door)::IndexedDoor
        p, _ = order_points(door.p, door.q)
        width = dclusters[length(door)]
        return IndexedDoor(distance(startpoint, p), width, door.type)
    end
    function define_element(window::Window)::IndexedWindow
        p, _ = order_points(window.p, window.q)
        width = wclusters[length(window)]
        return IndexedWindow(distance(startpoint, p), width)
    end

    return map(define_element, elements)
end
