include("Types.jl")

abstract type EmbeddedElement end

struct AdjustedWall
    p::XY
    q::XY
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

function AdjustedWall(wall::Wall, xclusters, xvalues, yclusters, yvalues)
    p, q = adjust_to_clusters(wall.p, wall.q, xclusters, xvalues, yclusters, yvalues)
    p, q = order_points(p, q)
    elements = embed_elements(p, wall.elements)

    return AdjustedWall(p, q, elements)
end

function adjust_to_clusters(p, q, xclusters, xvalues, yclusters, yvalues)
    p = XY(xvalues[xclusters[p.x]], yvalues[yclusters[p.y]])
    q = XY(xvalues[xclusters[q.x]], yvalues[yclusters[q.y]])

    return p, q
end

function embed_elements(startpoint, elements)
    function define_element(door::Door)::EmbeddedDoor
        p, _ = order_points(door.p, door.q)
        return EmbeddedDoor(distance(startpoint, p), length(door), door.type)
    end
    function define_element(window::Window)::EmbeddedWindow
        p, _ = order_points(window.p, window.q)
        return EmbeddedWindow(distance(startpoint, p), length(window))
    end

    return map(define_element, elements)
end


struct IndexedWall
    p::Index
    q::Index
    elements::Vector{EmbeddedElement}
end

function IndexedWall(wall::AdjustedWall, xclusters, yclusters, pclusters)
    p_coords = (xclusters[wall.p.x], yclusters[wall.p.y])
    p = pclusters[p_coords]

    q_coords = (xclusters[wall.q.x], yclusters[wall.q.y])
    q = pclusters[q_coords]

    return IndexedWall(p, q, wall.elements)
end

Base.isless(w1::IndexedWall, w2::IndexedWall) = w1.p < w2.p || (w1.p == w2.p && w1.q < w2.q)

order_points(p::XY, q::XY) = p < q ? (p, q) : (q, p)