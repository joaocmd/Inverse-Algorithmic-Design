import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("../OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.15; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.3; parts=parts)

x1 = 1.53
x2 = 2.54
x3 = 4.71
x4 = 6.65
x5 = 8.02
x6 = 9.0
x7 = 10.08
x8 = 10.47
x9 = 11.25
x10 = 13.56
x11 = 14.79
x12 = 15.15
x13 = 15.93

y1 = 1.44
y2 = 2.69
y3 = 4.71
y4 = 5.88
y5 = 7.26
y6 = 8.63
y7 = 9.27
y8 = 10.35
y9 = 11.25
y10 = 12.89
y11 = 13.8
y12 = 16.41
y13 = 18.7
y14 = 19.74
y15 = 21.36
y16 = 22.14
y17 = 23.82
y18 = 25.08

p1 = xy(x1, y9)
p2 = xy(x1, y10)
p3 = xy(x2, y2)
p4 = xy(x2, y4)
p5 = xy(x2, y8)
p6 = xy(x2, y11)
p7 = xy(x2, y13)
p8 = xy(x2, y14)
p9 = xy(x2, y16)
p10 = xy(x2, y17)
p11 = xy(x3, y2)
p12 = xy(x3, y13)
p13 = xy(x3, y15)
p14 = xy(x3, y18)
p15 = xy(x4, y1)
p16 = xy(x4, y2)
p17 = xy(x4, y10)
p18 = xy(x4, y11)
p19 = xy(x4, y13)
p20 = xy(x4, y15)
p21 = xy(x5, y2)
p22 = xy(x5, y3)
p23 = xy(x5, y4)
p24 = xy(x5, y5)
p25 = xy(x5, y15)
p26 = xy(x5, y18)
p27 = xy(x6, y5)
p28 = xy(x6, y6)
p29 = xy(x6, y7)
p30 = xy(x6, y10)
p31 = xy(x6, y12)
p32 = xy(x6, y13)
p33 = xy(x7, y15)
p34 = xy(x7, y18)
p35 = xy(x8, y3)
p36 = xy(x8, y5)
p37 = xy(x9, y2)
p38 = xy(x9, y3)
p39 = xy(x9, y5)
p40 = xy(x9, y6)
p41 = xy(x9, y12)
p42 = xy(x9, y13)
p43 = xy(x9, y15)
p44 = xy(x10, y2)
p45 = xy(x10, y6)
p46 = xy(x10, y10)
p47 = xy(x11, y10)
p48 = xy(x11, y12)
p49 = xy(x11, y15)
p50 = xy(x11, y18)
p51 = xy(x12, y6)
p52 = xy(x13, y6)
p53 = xy(x13, y10)

##

delete_all_shapes()

thinwall([p1, p2]; parts=[window(0.19, 1.2)])
thickwall([p1, p5]; parts=[window(0.26, 0.77)])
thickwall([p2, p6]; parts=[window(0.32, 0.77)])
thickwall([p4, p5]; parts=[window(0.24, 1.41)])
thickwall([p4, p23]; parts=[window(0.31, 3.0), door(3.97, 0.78, rr)])
thinwall([p6, p7]; parts=[window(1.05, 3.0)])
thinwall([p6, p18])
thickwall([p7, p12]; parts=[window(0.7, 0.91)])
thickwall([p12, p13]; parts=[door(0.98, 1.38, lf)])
thinwall([p12, p19])
thickwall([p13, p14]; parts=[window(2.04, 1.41)])
thinwall([p13, p20])
thickwall([p14, p26]; parts=[window(0.24, 0.54)])
thinwall([p17, p18])
thinwall([p19, p20]; parts=[door(1.04, 0.87, lf)])
thinwall([p20, p25]; parts=[door(0.31, 0.78, rf)])
thickwall([p21, p22]; parts=[window(1.12, 0.54)])
thickwall([p21, p37])
thickwall([p22, p23]; parts=[window(0.18, 0.54)])
thinwall([p22, p35]; parts=[door(0.41, 0.6, lr)])
thickwall([p23, p28])
thinwall([p24, p27])
thinwall([p25, p26])
thinwall([p25, p33]; parts=[door(0.47, 0.87, lr)])
thickwall([p26, p34]; parts=[window(0.41, 0.63)])
thinwall([p27, p29])
thinwall([p27, p36])
thinwall([p28, p40])
thinwall([p30, p31]; parts=[door(2.53, 0.78, rr)])
thinwall([p30, p46])
thinwall([p31, p32])
thinwall([p31, p41]; parts=[door(0.93, 0.6, lf)])
thinwall([p32, p42])
thinwall([p33, p34])
thinwall([p33, p43]; parts=[door(0.27, 0.78, lf)])
thickwall([p34, p50]; parts=[window(0.87, 0.63), window(3.99, 0.54)])
thinwall([p35, p36])
thinwall([p35, p38])
thinwall([p36, p39])
thinwall([p37, p38]; parts=[door(1.03, 0.78, rf)])
thickwall([p37, p44]; parts=[door(0.43, 0.87, rr)])
thinwall([p39, p40]; parts=[door(0.22, 0.6, rr)])
thinwall([p40, p45]; parts=[door(0.49, 0.87, lf)])
thinwall([p41, p42])
thinwall([p41, p48])
thinwall([p42, p43]; parts=[door(0.99, 0.78, rr)])
thinwall([p43, p49])
thickwall([p44, p45]; parts=[window(2.35, 1.2)])
thickwall([p45, p46]; parts=[door(0.25, 0.87, lr), window(2.5, 1.2)])
thickwall([p46, p47]; parts=[window(0.51, 0.54)])
thickwall([p47, p48]; parts=[window(0.22, 1.41)])
thickwall([p48, p49]; parts=[window(1.47, 2.16)])
thickwall([p49, p50]; parts=[window(1.98, 1.41)])

railing([p3, p4], 0.05)
railing([p3, p11], 0.05)
railing([p8, p9], 0.05)
railing([p9, p10], 0.05)
railing([p15, p16], 0.05)
railing([p47, p53], 0.05)
railing([p51, p52], 0.05)
railing([p52, p53], 0.05)

##

closet(xy(11.02, 2.95), xy(10.41, 3.17))
closet(xy(13.32, 3.33), xy(13.23, 3.63))
closet(xy(13.38, 4.83), xy(12.72, 2.88))
closet(xy(11.22, 4.8), xy(10.56, 7.17))
closet(xy(13.35, 6.48), xy(12.69, 7.92))
closet(xy(9.81, 13.08), xy(9.12, 15.27))
closet(xy(9.54, 16.53), xy(9.18, 16.77))
closet(xy(11.22, 17.01), xy(10.8, 16.5))
closet(xy(11.25, 19.47), xy(9.0, 18.75))
closet(xy(6.6, 19.5), xy(4.86, 18.75))
closet(xy(14.61, 20.61), xy(11.46, 21.27))
closet(xy(10.87, 24.86), xy(10.14, 22.56))
toilet(xy(9.51, 7.76), 270)
toilet(xy(9.57, 23.4), 90)
sink(xy(10.59, 8.37), 180)
sink(xy(10.81, 12.56), 180)
sink(xy(9.72, 22.23), 90)

##

show_auxiliary_labels(labels_only=false)
