import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("../OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.16; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.35; parts=parts)

x1 = 1.13
x2 = 4.74
x3 = 5.38
x4 = 6.93
x5 = 8.51
x6 = 11.43
x7 = 11.95
x8 = 12.54
x9 = 14.63
x10 = 15.7
x11 = 19.25
x12 = 21.45
x13 = 24.48
x14 = 25.88
x15 = 29.24

y1 = 2.73
y2 = 4.82
y3 = 7.06
y4 = 7.59
y5 = 11.42
y6 = 13.29

p1 = xy(x1, y1)
p2 = xy(x1, y3)
p3 = xy(x1, y6)
p4 = xy(x2, y1)
p5 = xy(x2, y3)
p6 = xy(x3, y3)
p7 = xy(x3, y5)
p8 = xy(x3, y6)
p9 = xy(x4, y1)
p10 = xy(x4, y3)
p11 = xy(x4, y5)
p12 = xy(x4, y6)
p13 = xy(x5, y1)
p14 = xy(x5, y2)
p15 = xy(x5, y3)
p16 = xy(x6, y2)
p17 = xy(x6, y3)
p18 = xy(x6, y5)
p19 = xy(x7, y1)
p20 = xy(x7, y2)
p21 = xy(x8, y3)
p22 = xy(x9, y1)
p23 = xy(x9, y2)
p24 = xy(x9, y3)
p25 = xy(x9, y5)
p26 = xy(x10, y1)
p27 = xy(x10, y3)
p28 = xy(x10, y6)
p29 = xy(x11, y1)
p30 = xy(x11, y3)
p31 = xy(x12, y1)
p32 = xy(x12, y2)
p33 = xy(x12, y4)
p34 = xy(x12, y5)
p35 = xy(x12, y6)
p36 = xy(x13, y3)
p37 = xy(x13, y4)
p38 = xy(x14, y1)
p39 = xy(x14, y2)
p40 = xy(x14, y3)
p41 = xy(x15, y1)
p42 = xy(x15, y3)
p43 = xy(x15, y5)

##

delete_all_shapes()

thickwall([p1, p2])
thickwall([p1, p4])
thickwall([p2, p3])
thinwall([p2, p5])
thickwall([p3, p8]; parts=[door(0.82, 2.1)])
thinwall([p4, p5]; parts=[door(3.22, 0.57, lr)])
thickwall([p4, p9])
thinwall([p5, p6])
thinwall([p7, p8])
thinwall([p7, p11]; parts=[door(0.34, 0.67, lr)])
thickwall([p8, p12]; parts=[window(0.25, 0.57)])
thinwall([p9, p10])
thickwall([p9, p13])
thinwall([p10, p15])
thickwall([p11, p12]; parts=[door(0.6, 0.8, lr)])
thickwall([p11, p18]; parts=[window(0.68, 1.75)])
thickwall([p13, p19])
thinwall([p14, p15]; parts=[door(0.34, 0.57, lf)])
thinwall([p14, p16])
thinwall([p15, p17])
thinwall([p16, p17]; parts=[door(0.34, 0.57, lf)])
thinwall([p16, p20])
thinwall([p17, p18]; parts=[door(3.09, 0.8, rf)])
thinwall([p17, p21])
thickwall([p18, p25]; parts=[window(0.19, 1.4)])
thinwall([p19, p20]; parts=[door(0.96, 0.67, lf)])
thickwall([p19, p22])
thinwall([p20, p23])
thickwall([p21, p24])
thickwall([p22, p23])
thickwall([p23, p24])
thickwall([p24, p25])
thickwall([p26, p27]; parts=[window(1.05, 1.75)])
thickwall([p26, p29])
thickwall([p27, p28])
thinwall([p27, p30])
thickwall([p28, p35]; parts=[window(0.78, 2.01), window(2.95, 2.01)])
thinwall([p29, p30]; parts=[door(3.31, 0.67, lr)])
thickwall([p29, p31]; parts=[window(0.42, 1.4)])
thinwall([p31, p32])
thickwall([p31, p38]; parts=[door(0.67, 0.92, lr), window(2.92, 1.11)])
thinwall([p32, p39]; parts=[door(2.89, 0.41, rf)])
thinwall([p33, p34])
thinwall([p33, p37])
thickwall([p34, p35]; parts=[window(0.51, 0.83)])
thickwall([p34, p43]; parts=[window(0.82, 1.4), door(3.69, 0.8, lf), window(4.55, 1.53)])
thinwall([p36, p37])
thinwall([p36, p40]; parts=[door(0.28, 0.67, rr)])
thinwall([p38, p39])
thickwall([p38, p41])
thinwall([p39, p40]; parts=[door(0.15, 0.67, lf)])
thinwall([p40, p42])
thickwall([p41, p42]; parts=[window(0.99, 1.53)])
thickwall([p42, p43])


##

closet(xy(9.3, 3.3), xy(8.52, 3.08))
closet(xy(23.93, 2.93), xy(23.35, 4.52))
closet(xy(28.92, 6.27), xy(26.12, 6.87))
closet(xy(18.33, 6.9), xy(15.94, 6.33))
closet(xy(7.67, 6.81), xy(7.06, 7.06))
closet(xy(24.37, 6.94), xy(21.29, 7.48))
toilet(xy(25.26, 4.3), 90)
sink(xy(10.05, 3.2), 0)
sink(xy(25.52, 3.63), 90)
sink(xy(27.57, 7.43), 0)

##

show_auxiliary_labels(labels_only=false)
