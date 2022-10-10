import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("OutAux.jl")

delete_all_shapes()

thinwall(wallpath; parts=[]) = wall(wallpath, 0.15; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.3; parts=parts)

# List of X and Y values. Alternatively, this part could be
# skipped and the points would use these values directly.
x1 = 0
x2 = 5

y1 = 0
y2 = 6
y3 = 8

# List of points created based on X and Y values.
p1 = xy(x1, y1)
p2 = xy(x1, y2)
p3 = xy(x1, y3)
p4 = xy(x2, y1)
p5 = xy(x2, y2)
p6 = xy(x2, y3)
# ...

# Definition of the walls based on the created points
thickwall([p1, p2])
thickwall([p1, p4]; parts=[door(1, 0.7, rf), window(2.3, 2)])
thickwall([p2, p3])
thinwall([p2, p5]; parts=[door(1, 0.7, lf)])
thickwall([p3, p6])
thickwall([p4, p5])
thickwall([p5, p6])
# ...

sink(xy(4.5, 7), 90)
toilet(xy(2.5, 7.7), 180)
closet(xy(4, 1), xy(5, 3))

show_auxiliary_labels(labels_only=false)
