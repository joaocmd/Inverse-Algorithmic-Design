using KhepriBlender

export mydoor, mywall, mywindow, show_points, show_x_lines, show_y_lines, DoorOrientation

line_padding = 0.3
label_height = 3.1
text_height = 0.3

# left forward, right forward, left reverse, right reverse
@enum DoorOrientation lf rf lr rr

struct MyDoor
    p::Real
    width::Real
    orientation::DoorOrientation
end

mydoor(p, width, orientation) = MyDoor(p, width, orientation)
mydoor(p, width) = mydoor(p, width, lp)

struct MyWindow
    p::Real
    width::Real
end

mywindow(p, width) = MyWindow(p, width)

function mywall(wall_path, thickness=0.2; parts=[])

    with_wall_family(thickness=thickness) do
        w = wall(wall_path)

        for part = parts
            if part isa MyWindow
                with_window_family(width=part.width) do
                    add_window(w, xy(part.p, 1))
                end
            elseif part isa MyDoor
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