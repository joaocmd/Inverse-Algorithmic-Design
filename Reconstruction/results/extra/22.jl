import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

# include("OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.03; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.1; parts=parts)

x1 = 0.25
x2 = 1.68
x3 = 2.49
x4 = 2.93
x5 = 3.42
x6 = 3.73
x7 = 4.09
x8 = 4.73

y1 = 0.39
y2 = 1.13
y3 = 2.05
y4 = 2.53
y5 = 3.07
y6 = 3.66
y7 = 4.0
y8 = 5.16

p1 = xy(x1, y4)
p2 = xy(x1, y7)
p3 = xy(x1, y8)
p4 = xy(x2, y7)
p5 = xy(x2, y8)
p6 = xy(x3, y4)
p7 = xy(x3, y5)
p8 = xy(x3, y6)
p9 = xy(x4, y1)
p10 = xy(x4, y4)
p11 = xy(x4, y5)
p12 = xy(x4, y7)
p13 = xy(x4, y8)
p14 = xy(x5, y4)
p15 = xy(x5, y5)
p16 = xy(x6, y1)
p17 = xy(x6, y2)
p18 = xy(x6, y3)
p19 = xy(x6, y4)
p20 = xy(x6, y5)
p21 = xy(x6, y6)
p22 = xy(x6, y7)
p23 = xy(x6, y8)
p24 = xy(x7, y3)
p25 = xy(x7, y4)
p26 = xy(x7, y5)
p27 = xy(x8, y1)
p28 = xy(x8, y3)
p29 = xy(x8, y4)
p30 = xy(x8, y5)
p31 = xy(x8, y6)
p32 = xy(x8, y8)

##

delete_all_shapes()

thickwall([p1, p2])
thickwall([p1, p6]; parts=[window(0.34, 1.66)])
thickwall([p2, p3]; parts=[window(0.17, 0.54)])
thinwall([p2, p4])
thickwall([p3, p5])
thinwall([p4, p5])
thinwall([p4, p12])
thickwall([p5, p13]; parts=[window(0.32, 0.54)])
thinwall([p6, p7])
thickwall([p6, p10]; parts=[door(0.21, 0.23, rr)])
thinwall([p7, p8])
thickwall([p9, p10]; parts=[window(1.02, 0.68)])
thickwall([p9, p16]; parts=[door(0.51, 0.23, rr)])
thinwall([p10, p11])
thinwall([p10, p14])
thinwall([p11, p15])
thinwall([p12, p13])
thinwall([p12, p22])
thickwall([p13, p23]; parts=[window(0.02, 0.54)])
thinwall([p14, p15])
thinwall([p14, p19])
thinwall([p15, p20])
thinwall([p16, p17])
thickwall([p16, p27]; parts=[door(0.17, 0.23, rr)])
thinwall([p17, p18])
thinwall([p18, p19]; parts=[door(0.25, 0.16, rf)])
thinwall([p18, p24])
thinwall([p19, p25])
thinwall([p20, p21]; parts=[door(0.14, 0.23, rf)])
thinwall([p21, p22]; parts=[door(0.08, 0.16, lr)])
thinwall([p21, p31])
thinwall([p22, p23])
thickwall([p23, p32]; parts=[window(0.04, 0.54)])
thinwall([p24, p25])
thinwall([p24, p28])
thinwall([p25, p26])
thinwall([p25, p29])
thinwall([p26, p30])
thickwall([p27, p30]; parts=[window(2.36, 0.25)])
thickwall([p28, p29]; parts=[door(0.05, 0.23, rr)])
thickwall([p29, p31])
thickwall([p30, p31]; parts=[window(0.28, 0.25)])
thickwall([p31, p32])


##

closet(xy(4.69, 3.7), xy(4.14, 3.89))
closet(xy(3.71, 4.01), xy(3.35, 4.2))
closet(xy(1.64, 4.03), xy(1.47, 5.1))
toilet(xy(3.18, 2.69), 0)
sink(xy(4.01, 3.58), 180)
sink(xy(1.79, 4.42), 270)

##

show_auxiliary_labels(labels_only=false)
