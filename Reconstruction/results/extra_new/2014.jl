import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("../OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.13; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.28; parts=parts)

x1 = 3.56
x2 = 5.57
x3 = 6.17
x4 = 7.22
x5 = 7.67
x6 = 8.54
x7 = 9.02
x8 = 9.69
x9 = 11.69
x10 = 15.55

y1 = 2.21
y2 = 2.68
y3 = 3.55
y4 = 5.0
y5 = 6.37
y6 = 7.03
y7 = 7.96
y8 = 9.73

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

thickwall([p1, p2])
thickwall([p1, p5]; parts=[door(0.91, 0.9, lr)])
thickwall([p2, p3]; parts=[window(1.67, 0.74)])
thinwall([p2, p6]; parts=[door(0.99, 0.79, rf)])
thickwall([p3, p4])
thinwall([p3, p9]; parts=[door(2.1, 0.7, rr)])
thickwall([p4, p12]; parts=[window(0.64, 1.51)])
thinwall([p5, p6])
thickwall([p5, p8])
thinwall([p6, p7])
thinwall([p7, p14]; parts=[door(0.27, 0.7, lr)])
thinwall([p8, p13])
thickwall([p9, p10])
thinwall([p9, p15])
thinwall([p10, p11])
thinwall([p10, p16])
thinwall([p11, p12])
thinwall([p11, p20]; parts=[door(1.1, 0.51, rr)])
thickwall([p12, p21]; parts=[window(0.88, 0.74)])
thinwall([p13, p14])
thinwall([p13, p17])
thinwall([p14, p18])
thinwall([p15, p16])
thinwall([p15, p19]; parts=[door(0.47, 0.7, rr)])
thinwall([p17, p23])
thinwall([p19, p20])
thinwall([p19, p25]; parts=[door(0.86, 0.7, rr)])
thinwall([p20, p21])
thickwall([p21, p26]; parts=[window(0.54, 1.51)])
thinwall([p22, p24])
thinwall([p23, p28])
thinwall([p25, p26])
thickwall([p26, p29])
thickwall([p27, p28])
thickwall([p28, p29]; parts=[window(0.6, 0.86), door(2.43, 0.79, rr), window(4.05, 1.91)])


##

closet(xy(4.09, 3.07), xy(3.88, 2.93))
closet(xy(4.28, 2.85), xy(3.72, 3.45))
closet(xy(4.28, 3.61), xy(3.69, 5.12))
closet(xy(9.69, 6.41), xy(9.1, 7.48))
closet(xy(7.11, 6.43), xy(6.52, 9.56))
toilet(xy(6.04, 3.23), 0)
sink(xy(9.96, 3.24), 0)
sink(xy(7.34, 3.82), 90)
sink(xy(7.86, 6.7), 270)

##

show_auxiliary_labels(labels_only=false)
