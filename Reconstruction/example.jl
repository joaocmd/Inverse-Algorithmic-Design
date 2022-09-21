import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriBlender", url="https://github.com/aptmcl/KhepriBlender.jl"))

using KhepriBlender: xy, delete_all_shapes
include("OutAux.jl")
x1 = 1.0
x2 = 4.0

y1 = 0.0
y2 = 4.0

p1 = xy(x1, y1)
p2 = xy(x1, y2)
p3 = xy(x2, y1)
p4 = xy(x2, y2)

##
delete_all_shapes()

wall1 = mywall([p1, p2], 0.3, parts=[mywindow(0.27, 0.53)])
wall2 = mywall([p1, p3], 0.3, parts=[mywindow(0.3, 1.36)])

##

namesx = [n for n = names(Main) if startswith(string(n), "x")]
namesy = [n for n = names(Main) if startswith(string(n), "y")]

show_x_lines(namesx, namesy)
show_y_lines(namesy, namesx)
show_points([n for n = names(Main) if startswith(string(n), "p")])
