Index = Int64
IndexTuple = Tuple{Index,Index}

struct XY
    x::Float64
    y::Float64
end

xy(tuple::Tuple{<:Real,<:Real})::XY = XY(tuple[1], tuple[2])
xy(vector::Vector{<:Real})::XY = XY(vector[1], vector[2])
Base.:-(p1::XY, p2::XY)::XY = XY(p1.x - p2.x, p1.y - p2.y)
Base.:+(p1::XY, p2::XY)::XY = XY(p1.x + p2.x, p1.y + p2.y)
Base.:*(p::XY, n::Real)::XY = XY(p.x * n, p.y * n)
Base.:/(p::XY, n::Real)::XY = XY(p.x / n, p.y / n)
Base.isless(p::XY, q::XY)::Bool = p.x < q.x || (p.x == q.x && p.y < q.y)

distance(p::XY, q::XY)::Float64 = length(p - q)
Base.length(v::XY)::Float64 = √(v.x^2 + v.y^2)
normalized(v::XY)::XY = v / length(v)
perpendicular(v::XY)::XY = normalized(XY(-v.y, v.x))

struct LineSegment
    p::XY
    q::XY
end

center(s::LineSegment)::XY = (s.p + s.q) / 2
vector(s::LineSegment)::XY = s.q - s.p
Base.length(s::LineSegment)::Float64 = length(vector(s))

# https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/
function intersect(s1, s2)

    function on_segment(p::XY, s::LineSegment)
        return (s.p.x <= max(p.x, s.q.x) && s.p.x >= min(p.x, s.q.x) &&
                s.p.y <= max(p.y, s.q.y) && s.p.y >= min(p.y, s.q.y))
    end

    function orientation(p, q, r)
        val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)

        if val == 0  # colinear
            return 0
        end

        return val > 0 ? 1 : 2 # clock or counterclock wise
    end

    p1, q1, p2, q2 = s1.p, s1.q, s2.p, s2.q


    # Find the four orientations needed for general and special cases
    o1 = orientation(p1, q1, p2)
    o2 = orientation(p1, q1, q2)
    o3 = orientation(p2, q2, p1)
    o4 = orientation(p2, q2, q1)

    # General case
    if o1 != o2 && o3 != o4
        return true
    end

    # Special Cases
    # p1, q1 and p2 are collinear and p2 lies on segment p1q1
    if o1 == 0 && on_segment(p1, LineSegment(p2, q1))
        return true
    end

    # p1, q1 and q2 are collinear and q2 lies on segment p1q1
    if o2 == 0 && on_segment(p1, LineSegment(q2, q1))
        return true
    end

    # p2, q2 and p1 are collinear and p1 lies on segment p2q2
    if o3 == 0 && on_segment(p2, LineSegment(p1, q2))
        return true
    end

    # p2, q2 and q1 are collinear and q1 lies on segment p2q2
    if o4 == 0 && on_segment(p2, LineSegment(q1, q2))
        return true
    end

    return false # Doesn't fall in any of the above cases
end

abstract type WallElement end

mutable struct Door <: WallElement
    p::XY
    q::XY
    type::String
end

mutable struct Window <: WallElement
    p::XY
    q::XY
end

segment(door::WallElement) = LineSegment(door.p, door.q)
center(door::WallElement) = center(segment(door))
Base.length(door::WallElement) = length(segment(door))

mutable struct Wall
    p::XY
    q::XY
    thickness::Float64
    elements::Vector{WallElement}
end

segment(w::Wall) = LineSegment(w.p, w.q)

function Wall(wall::Dict{Any,Any})
    points, thickness = wall["points"], wall["width"]
    p, q = xy(points[1, :]), xy(points[2, :])
    processed_elements = WallElement[]

    if "elements" in keys(wall)
        for el in wall["elements"]
            s, e = xy(el["points"][1, :]), xy(el["points"][2, :])
            if el["type"] == "window"
                push!(processed_elements, Window(s, e))
            else
                push!(processed_elements, Door(s, e, el["orientation"]))
            end
        end
    end

    return Wall(p, q, thickness, processed_elements)
end

Base.isless(w1::Wall, w2::Wall)::Bool = w1.p < w2.p || (w1.p == w2.p && w1.q < w2.q)

