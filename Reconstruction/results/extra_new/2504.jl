import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("../OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.13; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.37; parts=parts)

x1 = 0.36
x2 = 2.22
x3 = 3.31
x4 = 4.86
x5 = 5.36
x6 = 6.86

y1 = 0.36
y2 = 1.25
y3 = 2.65
y4 = 3.76
y5 = 4.94
y6 = 5.86
y7 = 8.08
y8 = 8.75
y9 = 10.09

p1 = xy(x1, y2)
p2 = xy(x1, y4)
p3 = xy(x2, y1)
p4 = xy(x2, y2)
p5 = xy(x2, y3)
p6 = xy(x2, y4)
p7 = xy(x2, y7)
p8 = xy(x2, y9)
p9 = xy(x3, y7)
p10 = xy(x4, y6)
p11 = xy(x5, y1)
p12 = xy(x5, y3)
p13 = xy(x5, y4)
p14 = xy(x5, y5)
p15 = xy(x5, y6)
p16 = xy(x5, y7)
p17 = xy(x5, y8)
p18 = xy(x5, y9)
p19 = xy(x6, y3)
p20 = xy(x6, y6)
p21 = xy(x6, y8)
p22 = xy(x6, y9)

##

delete_all_shapes()

thickwall([p3, p4]; parts=[window(0.22, 0.44)])
thinwall([p3, p11])
thickwall([p4, p5]; parts=[window(0.17, 0.79)])
thinwall([p5, p6]; parts=[door(0.24, 0.69, rf)])
thinwall([p5, p12])
thickwall([p6, p7]; parts=[window(0.27, 1.04), window(1.93, 1.66)])
thickwall([p7, p8]; parts=[window(0.24, 0.79), window(1.31, 0.44)])
thinwall([p7, p9])
thickwall([p8, p18]; parts=[window(2.09, 0.44)])
thinwall([p9, p16])
thinwall([p10, p15])
thinwall([p11, p12])
thinwall([p12, p19]; parts=[door(0.23, 0.69)])
thinwall([p13, p14])
thinwall([p15, p16])
thinwall([p15, p20]; parts=[door(0.14, 0.57, rr)])
thinwall([p16, p17]; parts=[door(0.13, 0.4, lf)])
thinwall([p17, p18])
thinwall([p17, p21]; parts=[door(0.3, 0.4, lr)])
thickwall([p18, p22])
thinwall([p19, p20])
thinwall([p20, p21])
thinwall([p21, p22])

railing([p1, p2], 0.07)
railing([p1, p4], 0.07)

##

closet(xy(5.36, 1.71), xy(4.88, 0.46))
closet(xy(5.27, 2.3), xy(5.01, 2.52))
closet(xy(6.8, 2.69), xy(6.34, 5.75))
closet(xy(5.31, 8.86), xy(4.83, 9.93))
toilet(xy(6.51, 7.64), 90)
sink(xy(6.65, 6.94), 90)
sink(xy(5.06, 7.22), 90)

##

show_auxiliary_labels(labels_only=false)
