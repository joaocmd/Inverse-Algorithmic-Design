# using KhepriBlender
import KhepriAutoCAD
using KhepriAutoCAD: with_wall_family, with_door_family, with_window_family, add_door, add_window, vxyz, xyz, xy, x, line, text, regular_prism, cylinder, box

export toilet, sink, closet, door, wall, window, show_points, show_x_lines, show_y_lines, DoorOrientation

line_padding = 0.3
label_height = 3.1
text_height = 0.3

# objects
function toilet(loc, angle)
    regular_prism(edges=5, angle=deg2rad(90 + angle), cb=xyz(loc.x, loc.y, 0), h=0.3, r=0.2, inscribed=true, material=KhepriAutoCAD.material_clay)
    regular_prism(edges=3, angle=deg2rad(90 + angle), cb=xyz(loc.x, loc.y, 0.3), h=0.2, r=0.4, inscribed=true, material=KhepriAutoCAD.material_clay)
end

function sink(loc, angle)
    cylinder(cb=xyz(loc.x, loc.y, 0), h=0.95, r=0.15, material=KhepriAutoCAD.material_clay)
    regular_prism(edges=5, angle=deg2rad(90 + angle), cb=xyz(loc.x, loc.y, 1), h=0.25, r=0.5, inscribed=true, material=KhepriAutoCAD.material_clay)
end

closet(p, q) = box(p, xyz(q.x, q.y, 1.2), material=KhepriAutoCAD.material_wood)

# left forward, right forward, left reverse, right reverse
@enum DoorOrientation lf rf lr rr

struct Door
    p::Real
    width::Real
    orientation::DoorOrientation
end

door(p, width, orientation) = Door(p, width, orientation)
door(p, width) = door(p, width, lf)

struct Window
    p::Real
    width::Real
end

window(p, width) = Window(p, width)

function wall(wallpath, thickness=0.2; parts=[])

    with_wall_family(thickness=thickness) do
        w = KhepriAutoCAD.wall(wallpath)

        for part = parts
            if part isa Window
                with_window_family(width=part.width) do
                    add_window(w, xy(part.p, 1))
                end
            elseif part isa Door
                with_door_family(width=part.width) do
                    add_door(w, x(part.p))
                end
            end
        end
        return w
    end
end

function show_points(names)
    for name = names
        pos = eval(:(Main.$name))
        text(string(name), pos + vxyz(0.1, 0.1, label_height), text_height)
    end
end

function show_x_lines(names)
    for name = names
        x = eval(:(Main.$name))
        line(xyz(x, 0, label_height), xyz(x, 25, label_height))
        text(string(name), xyz(x, -1, label_height), text_height)
    end
end

function show_x_lines(xnames, ynames)
    yvalues = [eval(:(Main.$name)) for name = ynames]
    m, M = min(yvalues...), max(yvalues...)

    for name = xnames
        x = eval(:(Main.$name))
        line(xyz(x, m - line_padding, label_height), xyz(x, M + line_padding, label_height))
        text(string(name), xyz(x, m - line_padding - 1, label_height), text_height)
    end
end

function show_y_lines(ynames, xnames)
    xvalues = [eval(:(Main.$name)) for name = xnames]
    m, M = min(xvalues...), max(xvalues...)

    for name = ynames
        y = eval(:(Main.$name))
        line(xyz(m - line_padding, y, label_height), xyz(M + line_padding, y, label_height))
        text(string(name), xyz(m - line_padding - 1, y, label_height), text_height)
    end
end