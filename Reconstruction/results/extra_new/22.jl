import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("../OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.05; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.16; parts=parts)

x1 = 0.38
x2 = 2.59
x3 = 3.84
x4 = 4.28
x5 = 4.68
x6 = 5.27
x7 = 5.75
x8 = 6.29
x9 = 7.27

y1 = 0.6
y2 = 1.73
y3 = 3.15
y4 = 3.89
y5 = 4.72
y6 = 5.63
y7 = 6.16
y8 = 7.94

p1 = xy(x1, y4)
p2 = xy(x1, y7)
p3 = xy(x1, y8)
p4 = xy(x2, y7)
p5 = xy(x2, y8)
p6 = xy(x3, y4)
p7 = xy(x3, y5)
p8 = xy(x3, y6)
p9 = xy(x4, y7)
p10 = xy(x4, y8)
p11 = xy(x5, y1)
p12 = xy(x5, y4)
p13 = xy(x5, y5)
p14 = xy(x6, y4)
p15 = xy(x6, y5)
p16 = xy(x7, y1)
p17 = xy(x7, y2)
p18 = xy(x7, y3)
p19 = xy(x7, y4)
p20 = xy(x7, y5)
p21 = xy(x7, y6)
p22 = xy(x7, y7)
p23 = xy(x7, y8)
p24 = xy(x8, y3)
p25 = xy(x8, y4)
p26 = xy(x8, y5)
p27 = xy(x9, y1)
p28 = xy(x9, y3)
p29 = xy(x9, y4)
p30 = xy(x9, y5)
p31 = xy(x9, y6)
p32 = xy(x9, y8)

##

delete_all_shapes()

thickwall([p1, p2])
thickwall([p1, p6]; parts=[window(0.53, 2.55)])
thickwall([p2, p3]; parts=[window(0.25, 0.84)])
thinwall([p2, p4])
thickwall([p3, p5])
thinwall([p4, p5])
thinwall([p4, p9])
thickwall([p5, p10]; parts=[window(0.49, 0.84)])
thinwall([p6, p7])
thickwall([p6, p12]; parts=[door(0.31, 0.35, rr)])
thinwall([p7, p8])
thinwall([p9, p10])
thinwall([p9, p22])
thickwall([p10, p23]; parts=[window(0.19, 0.84)])
thickwall([p11, p12]; parts=[window(1.57, 1.05)])
thickwall([p11, p16]; parts=[door(0.62, 0.35, rr)])
thinwall([p12, p13])
thinwall([p12, p14])
thinwall([p13, p15])
thinwall([p14, p15])
thinwall([p14, p19])
thinwall([p15, p20])
thinwall([p16, p17])
thickwall([p16, p27]; parts=[door(0.25, 0.35, rr)])
thinwall([p17, p18])
thinwall([p18, p19]; parts=[door(0.39, 0.25, rf)])
thinwall([p18, p24])
thinwall([p19, p25])
thinwall([p20, p21]; parts=[door(0.23, 0.35, rf)])
thinwall([p21, p22]; parts=[door(0.13, 0.25, lr)])
thinwall([p21, p31])
thinwall([p22, p23])
thickwall([p23, p32]; parts=[window(0.06, 0.84)])
thinwall([p24, p25])
thinwall([p24, p28])
thinwall([p25, p26])
thinwall([p25, p29])
thinwall([p26, p30])
thickwall([p28, p29]; parts=[door(0.09, 0.35, rr)])
thickwall([p29, p30]; parts=[window(0.35, 0.39)])
thickwall([p30, p31]; parts=[window(0.44, 0.39)])
thickwall([p31, p32])


##

closet(xy(7.21, 5.7), xy(6.36, 5.98))
closet(xy(5.71, 6.17), xy(5.15, 6.46))
closet(xy(2.53, 6.2), xy(2.26, 7.84))
toilet(xy(4.89, 4.14), 0)
sink(xy(6.16, 5.5), 180)
sink(xy(2.76, 6.8), 270)

##

show_auxiliary_labels(labels_only=false)
