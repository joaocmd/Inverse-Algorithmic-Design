import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("../OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.08; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.3; parts=parts)

x1 = 0.28
x2 = 1.8
x3 = 2.68
x4 = 3.96
x5 = 4.35
x6 = 5.58

y1 = 0.28
y2 = 1.02
y3 = 2.16
y4 = 3.06
y5 = 4.02
y6 = 4.77
y7 = 6.58
y8 = 7.12
y9 = 8.24

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

thickwall([p3, p4]; parts=[window(0.18, 0.36)])
thinwall([p3, p11])
thickwall([p4, p5]; parts=[window(0.14, 0.64)])
thickwall([p5, p6]; parts=[door(0.22, 0.56, rf)])
thinwall([p5, p12])
thickwall([p6, p7]; parts=[window(0.22, 0.84), window(1.58, 1.35)])
thickwall([p7, p8]; parts=[window(0.2, 0.64), window(1.07, 0.36)])
thinwall([p7, p9])
thickwall([p8, p22]; parts=[window(1.71, 0.36)])
thinwall([p9, p16])
thinwall([p10, p15])
thinwall([p11, p12])
thinwall([p12, p19]; parts=[door(0.2, 0.56)])
thinwall([p13, p14])
thinwall([p15, p16])
thinwall([p15, p20]; parts=[door(0.12, 0.46, rr)])
thinwall([p16, p17]; parts=[door(0.1, 0.32, lf)])
thinwall([p17, p18])
thinwall([p17, p21]; parts=[door(0.25, 0.32, lr)])
thickwall([p18, p22])
thinwall([p19, p20])
thinwall([p20, p21])
thinwall([p21, p22])

railing([p1, p2], 0.05)
railing([p1, p4], 0.05)

##

closet(xy(4.36, 1.4), xy(3.97, 0.38))
closet(xy(4.29, 1.88), xy(4.08, 2.05))
closet(xy(5.54, 2.19), xy(5.16, 4.68))
closet(xy(4.32, 7.22), xy(3.93, 8.08))
toilet(xy(5.3, 6.22), 90)
sink(xy(5.42, 5.65), 90)
sink(xy(4.12, 5.88), 90)

##

show_auxiliary_labels(labels_only=false)
