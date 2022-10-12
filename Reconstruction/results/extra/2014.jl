import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("../OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.12; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.3; parts=parts)

x1 = 3.3
x2 = 5.18
x3 = 5.72
x4 = 6.7
x5 = 7.1
x6 = 7.93
x7 = 8.38
x8 = 9.0
x9 = 10.85
x10 = 14.42

y1 = 2.05
y2 = 2.51
y3 = 3.3
y4 = 4.65
y5 = 5.92
y6 = 6.52
y7 = 7.4
y8 = 9.05

p1 = xy(x1, y2)
p2 = xy(x1, y3)
p3 = xy(x1, y5)
p4 = xy(x1, y8)
p5 = xy(x2, y2)
p6 = xy(x2, y3)
p7 = xy(x2, y4)
p8 = xy(x3, y2)
p9 = xy(x4, y5)
p10 = xy(x4, y6)
p11 = xy(x4, y7)
p12 = xy(x4, y8)
p13 = xy(x5, y2)
p14 = xy(x5, y4)
p15 = xy(x5, y5)
p16 = xy(x5, y6)
p17 = xy(x6, y2)
p18 = xy(x6, y4)
p19 = xy(x7, y5)
p20 = xy(x7, y7)
p21 = xy(x7, y8)
p22 = xy(x8, y4)
p23 = xy(x9, y2)
p24 = xy(x9, y4)
p25 = xy(x9, y5)
p26 = xy(x9, y8)
p27 = xy(x10, y1)
p28 = xy(x10, y2)
p29 = xy(x10, y8)

##

delete_all_shapes()

thinwall([p1, p2])
thickwall([p1, p5]; parts=[door(0.86, 0.83, lr)])
thinwall([p2, p3]; parts=[window(1.55, 0.69)])
thinwall([p2, p6]; parts=[door(0.93, 0.74, rf)])
thinwall([p3, p4])
thinwall([p3, p9]; parts=[door(1.95, 0.65, rr)])
thickwall([p4, p12]; parts=[window(0.6, 1.4)])
thinwall([p5, p6])
thickwall([p5, p8])
thinwall([p6, p7])
thinwall([p7, p14]; parts=[door(0.25, 0.65, lr)])
thinwall([p8, p13])
thickwall([p9, p10])
thinwall([p9, p15])
thinwall([p10, p11])
thinwall([p10, p16])
thinwall([p11, p12])
thinwall([p11, p20]; parts=[door(1.03, 0.47, rr)])
thickwall([p12, p21]; parts=[window(0.83, 0.69)])
thinwall([p13, p14])
thinwall([p13, p17])
thinwall([p14, p18])
thinwall([p15, p16])
thinwall([p15, p19]; parts=[door(0.45, 0.65, rr)])
thinwall([p17, p23])
thinwall([p19, p20])
thinwall([p19, p25]; parts=[door(0.8, 0.65, rr)])
thinwall([p20, p21])
thickwall([p21, p26]; parts=[window(0.5, 1.4)])
thinwall([p22, p24])
thinwall([p23, p28])
thinwall([p25, p26])
thickwall([p26, p29])
thickwall([p27, p28])
thinwall([p28, p29]; parts=[window(0.54, 0.8), door(2.24, 0.74, rr), window(3.74, 1.78)])


##

closet(xy(3.8, 2.85), xy(3.6, 2.72))
closet(xy(3.97, 2.65), xy(3.45, 3.2))
closet(xy(3.97, 3.35), xy(3.42, 4.75))
closet(xy(9.0, 5.95), xy(8.45, 6.95))
closet(xy(6.6, 5.98), xy(6.05, 8.88))
toilet(xy(5.61, 3.0), 0)
sink(xy(9.25, 3.01), 0)
sink(xy(6.81, 3.55), 90)
sink(xy(7.3, 6.22), 270)

##

show_auxiliary_labels(labels_only=false)
