include("Types.jl")

order_points(p::XY, q::XY) = p < q ? (p, q) : (q, p)

abstract type EmbeddedElement end

struct AdjustedWall
    p::XY
    q::XY
    thickness::Float64
    elements::Vector{EmbeddedElement}
end

struct EmbeddedDoor <: EmbeddedElement
    p::Float64
    width::Float64
    type::String
end

struct EmbeddedWindow <: EmbeddedElement
    p::Float64
    width::Float64
end

function AdjustedWall(wall, xclusters, xvalues, yclusters, yvalues,
    tclusters, tvalues,
    dclusters, dvalues, wclusters, wvalues)

    p, q = adjust_to_clusters(wall.p, wall.q, xclusters, xvalues, yclusters, yvalues)
    p, q = order_points(p, q)
    elements = embed_elements(p, wall.elements, dclusters, dvalues, wclusters, wvalues)

    return AdjustedWall(p, q, tvalues[tclusters[wall.thickness]], elements)
end

function adjust_to_clusters(p, q, xclusters, xvalues, yclusters, yvalues)
    p = XY(xvalues[xclusters[p.x]], yvalues[yclusters[p.y]])
    q = XY(xvalues[xclusters[q.x]], yvalues[yclusters[q.y]])

    return p, q
end

function embed_elements(startpoint, elements,
    dclusters, dvalues, wclusters, wvalues)
    function define_element(door::Door)::EmbeddedDoor
        p, _ = order_points(door.p, door.q)
        width = dvalues[dclusters[length(door)]]
        return EmbeddedDoor(distance(startpoint, p), width, door.type)
    end
    function define_element(window::Window)::EmbeddedWindow
        p, _ = order_points(window.p, window.q)
        width = wvalues[wclusters[length(window)]]
        return EmbeddedWindow(distance(startpoint, p), width)
    end

    return map(define_element, elements)
end

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

function IndexedWall(wall, xclusters, yclusters, pclusters,
    tclusters, dclusters, wclusters)

    p_coords = (xclusters[wall.p.x], yclusters[wall.p.y])
    p = pclusters[p_coords]

    q_coords = (xclusters[wall.q.x], yclusters[wall.q.y])
    q = pclusters[q_coords]

    elements = index_elements(wall.elements, dclusters, wclusters)

    return IndexedWall(p, q, tclusters[wall.thickness], elements)
end

function index_elements(elements, dclusters, wclusters)
    define_element(door::EmbeddedDoor) = IndexedDoor(door.p, dclusters[door.width], door.type)
    define_element(window::EmbeddedWindow) = IndexedWindow(window.p, wclusters[window.width])

    return map(define_element, elements)
end
