import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("../OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.12; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.3; parts=parts)

x1 = 0.95
x2 = 4.06
x3 = 4.61
x4 = 5.92
x5 = 7.28
x6 = 9.79
x7 = 10.23
x8 = 10.75
x9 = 12.55
x10 = 13.45
x11 = 16.5
x12 = 18.38
x13 = 20.97
x14 = 22.18
x15 = 25.06

y1 = 2.36
y2 = 4.15
y3 = 6.08
y4 = 6.52
y5 = 9.8
y6 = 11.4

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
thinwall([p2, p6])
thickwall([p3, p8]; parts=[door(0.71, 1.8)])
thinwall([p4, p5]; parts=[door(2.74, 0.49, lr)])
thickwall([p4, p9])
thinwall([p7, p8])
thinwall([p7, p11]; parts=[door(0.29, 0.57, lr)])
thickwall([p8, p12]; parts=[window(0.22, 0.49)])
thinwall([p9, p10])
thickwall([p9, p13])
thinwall([p10, p15])
thickwall([p11, p12]; parts=[door(0.51, 0.67, lr)])
thickwall([p11, p18]; parts=[window(0.6, 1.5)])
thickwall([p13, p19])
thinwall([p14, p15]; parts=[door(0.27, 0.49, lf)])
thinwall([p14, p16])
thinwall([p15, p17])
thinwall([p16, p17]; parts=[door(0.27, 0.49, lf)])
thinwall([p16, p20])
thinwall([p17, p18]; parts=[door(2.63, 0.67, rf)])
thinwall([p17, p21])
thickwall([p18, p25]; parts=[window(0.17, 1.2)])
thinwall([p19, p20]; parts=[door(0.8, 0.57, lf)])
thickwall([p19, p22])
thinwall([p20, p23])
thickwall([p21, p24])
thickwall([p22, p23])
thickwall([p23, p24])
thickwall([p24, p25])
thinwall([p24, p30])
thickwall([p26, p27]; parts=[window(0.88, 1.5)])
thickwall([p26, p29])
thickwall([p27, p28])
thickwall([p28, p35]; parts=[window(0.68, 1.72), window(2.54, 1.72)])
thinwall([p29, p30]; parts=[door(2.82, 0.57, lr)])
thickwall([p29, p31]; parts=[window(0.37, 1.2)])
thinwall([p31, p32])
thickwall([p31, p38]; parts=[door(0.58, 0.79, lr), window(2.51, 0.95)])
thinwall([p32, p39]; parts=[door(2.49, 0.35, rf)])
thinwall([p33, p34])
thinwall([p33, p37])
thickwall([p34, p35]; parts=[window(0.43, 0.71)])
thickwall([p34, p43]; parts=[window(0.71, 1.2), door(3.16, 0.67, lf), window(3.9, 1.31)])
thinwall([p36, p37])
thinwall([p36, p40]; parts=[door(0.26, 0.57, rr)])
thinwall([p38, p39])
thickwall([p38, p41])
thinwall([p39, p40]; parts=[door(0.12, 0.67, lf)])
thinwall([p40, p42])
thickwall([p41, p42]; parts=[window(0.83, 1.31)])
thickwall([p42, p43])


##

closet(xy(7.97, 2.83), xy(7.3, 2.64))
closet(xy(20.51, 2.51), xy(20.02, 3.87))
closet(xy(24.79, 5.37), xy(22.39, 5.89))
closet(xy(15.71, 5.92), xy(13.66, 5.43))
closet(xy(6.57, 5.84), xy(6.05, 6.05))
closet(xy(20.89, 5.95), xy(18.25, 6.41))
toilet(xy(21.65, 3.68), 90)
sink(xy(8.62, 2.74), 0)
sink(xy(21.87, 3.11), 90)
sink(xy(23.63, 6.37), 0)

##

show_auxiliary_labels(labels_only=true)
