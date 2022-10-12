import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("../OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.16; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.35; parts=parts)

x1 = 3.49
x2 = 5.36
x3 = 6.54
x4 = 6.97
x5 = 8.77
x6 = 9.53
x7 = 12.58
x8 = 16.15
x9 = 18.1
x10 = 19.83
x11 = 22.62
x12 = 23.67

y1 = 1.8
y2 = 3.11
y3 = 5.45
y4 = 5.89
y5 = 6.9
y6 = 8.49
y7 = 9.27
y8 = 10.45
y9 = 10.98
y10 = 12.23
y11 = 14.9

p1 = xy(x1, y1)
p2 = xy(x1, y5)
p3 = xy(x1, y6)
p4 = xy(x1, y8)
p5 = xy(x1, y10)
p6 = xy(x1, y11)
p7 = xy(x2, y6)
p8 = xy(x2, y8)
p9 = xy(x2, y10)
p10 = xy(x3, y5)
p11 = xy(x3, y6)
p12 = xy(x3, y10)
p13 = xy(x3, y11)
p14 = xy(x4, y5)
p15 = xy(x5, y1)
p16 = xy(x5, y5)
p17 = xy(x5, y10)
p18 = xy(x5, y11)
p19 = xy(x6, y5)
p20 = xy(x6, y6)
p21 = xy(x6, y10)
p22 = xy(x7, y9)
p23 = xy(x7, y11)
p24 = xy(x8, y1)
p25 = xy(x8, y2)
p26 = xy(x8, y3)
p27 = xy(x8, y4)
p28 = xy(x8, y5)
p29 = xy(x9, y2)
p30 = xy(x9, y3)
p31 = xy(x9, y6)
p32 = xy(x9, y7)
p33 = xy(x10, y1)
p34 = xy(x10, y2)
p35 = xy(x10, y3)
p36 = xy(x10, y4)
p37 = xy(x10, y5)
p38 = xy(x10, y7)
p39 = xy(x11, y5)
p40 = xy(x12, y1)
p41 = xy(x12, y5)
p42 = xy(x12, y7)
p43 = xy(x12, y11)

##

delete_all_shapes()

thickwall([p1, p2])
thickwall([p1, p15]; parts=[window(1.13, 0.46)])
thickwall([p2, p3]; parts=[door(0.3, 0.93)])
thinwall([p2, p10]; parts=[door(2.08, 0.7, lr)])
thickwall([p3, p4])
thinwall([p3, p7])
thickwall([p4, p5])
thinwall([p4, p8])
thickwall([p5, p6])
thinwall([p5, p9])
thickwall([p6, p13])
thinwall([p7, p8])
thinwall([p7, p11])
thinwall([p8, p9]; parts=[door(0.43, 0.7, rr)])
thinwall([p9, p12])
thinwall([p10, p14])
thinwall([p11, p20]; parts=[door(1.54, 0.4, rf)])
thinwall([p12, p13]; parts=[door(0.47, 0.7, rf)])
thickwall([p13, p18])
thinwall([p14, p16])
thinwall([p15, p16])
thickwall([p15, p24]; parts=[window(0.9, 0.46), window(4.56, 1.77)])
thinwall([p16, p19])
thinwall([p17, p18])
thinwall([p17, p21])
thickwall([p18, p23]; parts=[door(0.93, 0.84, rf)])
thinwall([p19, p20])
thinwall([p19, p28])
thinwall([p20, p21]; parts=[door(0.54, 0.84, lf)])
thinwall([p22, p23])
thickwall([p23, p43]; parts=[window(2.0, 3.85), window(5.94, 1.88)])
thickwall([p24, p25])
thinwall([p25, p26])
thickwall([p25, p29]; parts=[door(0.78, 0.93, rr)])
thinwall([p26, p27])
thinwall([p26, p30])
thinwall([p27, p28])
thinwall([p29, p30])
thickwall([p29, p34])
thinwall([p30, p35])
thinwall([p31, p32])
thinwall([p32, p38])
thickwall([p33, p34])
thickwall([p33, p40]; parts=[window(0.97, 1.77)])
thinwall([p34, p35])
thickwall([p35, p36])
thinwall([p36, p37]; parts=[door(0.26, 0.4, rr)])
thinwall([p37, p38])
thinwall([p37, p39])
thinwall([p38, p42])
thinwall([p39, p41])
thickwall([p40, p41])
thickwall([p41, p42])
thickwall([p42, p43])


##

closet(xy(19.63, 4.74), xy(19.41, 4.87))
closet(xy(8.66, 4.75), xy(8.08, 5.28))
closet(xy(21.73, 7.1), xy(21.29, 7.51))
closet(xy(7.1, 8.05), xy(6.81, 7.25))
closet(xy(7.57, 7.03), xy(6.52, 8.34))
closet(xy(9.39, 7.03), xy(8.85, 8.37))
closet(xy(19.66, 9.16), xy(18.2, 8.72))
closet(xy(23.45, 9.2), xy(22.75, 7.06))
closet(xy(9.39, 11.49), xy(8.91, 12.19))
sink(xy(18.63, 3.63), 0)
sink(xy(19.54, 5.0), 90)
sink(xy(4.79, 9.91), 180)
sink(xy(7.17, 11.85), 180)
sink(xy(9.2, 13.73), 270)

##

show_auxiliary_labels(labels_only=true)
