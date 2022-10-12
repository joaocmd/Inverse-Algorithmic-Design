import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("../OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.16; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.35; parts=parts)

x1 = 1.52
x2 = 2.83
x3 = 4.61
x4 = 5.44
x5 = 7.16
x6 = 8.28
x7 = 10.7
x8 = 13.46
x9 = 14.43
x10 = 16.16
x11 = 17.12
x12 = 18.26
x13 = 18.97
x14 = 20.42
x15 = 21.86
x16 = 23.1
x17 = 25.27
x18 = 26.54

y1 = 1.65
y2 = 2.71
y3 = 5.02
y4 = 7.07
y5 = 8.53
y6 = 9.58
y7 = 10.72
y8 = 11.12
y9 = 11.95
y10 = 14.39
y11 = 15.72
y12 = 16.07
y13 = 16.93

p1 = xy(x1, y3)
p2 = xy(x1, y5)
p3 = xy(x1, y7)
p4 = xy(x1, y11)
p5 = xy(x2, y2)
p6 = xy(x3, y2)
p7 = xy(x4, y3)
p8 = xy(x4, y4)
p9 = xy(x4, y5)
p10 = xy(x4, y7)
p11 = xy(x4, y9)
p12 = xy(x4, y11)
p13 = xy(x5, y2)
p14 = xy(x6, y2)
p15 = xy(x6, y3)
p16 = xy(x6, y4)
p17 = xy(x6, y6)
p18 = xy(x6, y9)
p19 = xy(x7, y6)
p20 = xy(x7, y9)
p21 = xy(x7, y11)
p22 = xy(x8, y2)
p23 = xy(x8, y4)
p24 = xy(x9, y1)
p25 = xy(x9, y4)
p26 = xy(x9, y6)
p27 = xy(x9, y10)
p28 = xy(x9, y11)
p29 = xy(x9, y13)
p30 = xy(x10, y1)
p31 = xy(x11, y2)
p32 = xy(x12, y6)
p33 = xy(x13, y6)
p34 = xy(x13, y9)
p35 = xy(x13, y10)
p36 = xy(x13, y12)
p37 = xy(x13, y13)
p38 = xy(x14, y5)
p39 = xy(x14, y6)
p40 = xy(x14, y8)
p41 = xy(x14, y9)
p42 = xy(x15, y2)
p43 = xy(x15, y5)
p44 = xy(x16, y5)
p45 = xy(x16, y8)
p46 = xy(x16, y9)
p47 = xy(x17, y2)
p48 = xy(x17, y3)
p49 = xy(x17, y4)
p50 = xy(x17, y5)
p51 = xy(x17, y9)
p52 = xy(x17, y10)
p53 = xy(x18, y4)

##

delete_all_shapes()

thickwall([p1, p2]; parts=[window(0.23, 0.59)])
thickwall([p1, p7]; parts=[window(0.26, 1.5)])
thickwall([p2, p3]; parts=[window(0.41, 0.59)])
thinwall([p2, p9])
thickwall([p3, p4]; parts=[window(0.89, 0.59), window(4.2, 0.59)])
thinwall([p3, p10])
thickwall([p4, p12]; parts=[window(0.29, 1.5)])
thinwall([p7, p8])
thickwall([p7, p15]; parts=[door(0.32, 1.46, rr)])
thinwall([p8, p9]; parts=[door(0.31, 0.83, rf)])
thinwall([p8, p16]; parts=[door(0.8, 0.92, rr)])
thinwall([p9, p10]; parts=[door(1.37, 0.82, lr)])
thinwall([p10, p11]; parts=[door(0.26, 0.83, lf)])
thinwall([p11, p12])
thinwall([p11, p18]; parts=[door(0.96, 0.83, lf)])
thickwall([p12, p21]; parts=[window(1.4, 2.29)])
thickwall([p14, p15]; parts=[window(0.73, 0.96)])
thickwall([p14, p22]; parts=[window(0.89, 3.18)])
thinwall([p15, p16])
thinwall([p17, p18])
thinwall([p17, p19])
thinwall([p18, p20])
thinwall([p19, p20]; parts=[door(0.95, 0.64, lf)])
thinwall([p19, p26]; parts=[door(0.21, 0.83, lf)])
thinwall([p20, p21])
thickwall([p21, p28]; parts=[window(2.03, 1.5)])
thinwall([p22, p23])
thickwall([p22, p24]; parts=[window(0.27, 0.81)])
thinwall([p23, p25])
thickwall([p24, p30]; parts=[window(0.33, 1.27)])
thinwall([p26, p27])
thickwall([p27, p28]; parts=[window(0.53, 0.59)])
thickwall([p27, p35]; parts=[window(0.59, 1.27), door(3.32, 0.92, rf)])
thickwall([p30, p31]; parts=[window(0.25, 0.81)])
thickwall([p31, p42]; parts=[window(2.99, 1.5)])
thinwall([p32, p33])
thinwall([p33, p34])
thinwall([p33, p39])
thinwall([p34, p35]; parts=[door(0.5, 0.92, lf)])
thinwall([p34, p41]; parts=[door(0.51, 0.64, lf)])
thickwall([p35, p52]; parts=[window(2.48, 1.27)])
thinwall([p38, p39])
thinwall([p38, p43])
thinwall([p39, p40])
thinwall([p40, p41])
thinwall([p40, p45])
thickwall([p42, p43]; parts=[window(0.32, 3.18), door(4.2, 0.83, rr)])
thickwall([p43, p44]; parts=[window(0.45, 0.59)])
thinwall([p44, p45]; parts=[door(0.41, 0.64, lr)])
thickwall([p44, p50]; parts=[window(0.45, 0.51)])
thinwall([p45, p46])
thinwall([p46, p51]; parts=[door(0.24, 0.83, lr)])
thickwall([p50, p51])
thickwall([p51, p52]; parts=[door(0.43, 0.92, rr)])

railing([p5, p6], 0.08)
railing([p6, p13], 0.08)
railing([p28, p29], 0.08)
railing([p29, p37], 0.08)
railing([p36, p37], 0.08)
railing([p42, p47], 0.08)
railing([p47, p48], 0.08)
railing([p49, p53], 0.08)

##

closet(xy(8.21, 5.19), xy(7.41, 7.03))
closet(xy(10.56, 10.15), xy(10.31, 9.77))
closet(xy(14.22, 9.7), xy(11.9, 10.44))
closet(xy(4.18, 11.52), xy(1.71, 10.83))
closet(xy(25.04, 11.12), xy(24.65, 11.67))
closet(xy(23.0, 11.93), xy(20.49, 11.23))
closet(xy(10.6, 11.49), xy(10.05, 11.93))
closet(xy(8.21, 9.58), xy(7.45, 11.96))
closet(xy(24.56, 14.06), xy(24.25, 14.16))
closet(xy(21.22, 13.49), xy(19.7, 14.19))
closet(xy(25.04, 13.52), xy(22.97, 14.22))
closet(xy(6.24, 12.19), xy(5.54, 15.53))
toilet(xy(19.87, 10.12), 0)
toilet(xy(3.28, 10.18), 180)
sink(xy(4.52, 10.34), 180)
sink(xy(19.22, 11.26), 270)
sink(xy(14.78, 11.5), 270)

##

show_auxiliary_labels(labels_only=false)
