import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

using KhepriAutoCAD: xy, delete_all_shapes
include("OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.14; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.3; parts=parts)

x1 = 1.28
x2 = 2.43
x3 = 3.95
x4 = 4.66
x5 = 6.14
x6 = 7.08
x7 = 9.16
x8 = 11.54
x9 = 12.37
x10 = 13.85
x11 = 14.67
x12 = 15.65
x13 = 16.23
x14 = 17.48
x15 = 18.74
x16 = 19.8
x17 = 21.64
x18 = 22.75

y1 = 1.42
y2 = 2.35
y3 = 4.31
y4 = 6.08
y5 = 7.32
y6 = 8.21
y7 = 9.19
y8 = 9.55
y9 = 10.25
y10 = 12.35
y11 = 13.52
y12 = 14.51

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
p29 = xy(x9, y12)
p30 = xy(x10, y1)
p31 = xy(x11, y2)
p32 = xy(x12, y6)
p33 = xy(x13, y6)
p34 = xy(x13, y9)
p35 = xy(x13, y10)
p36 = xy(x13, y11)
p37 = xy(x13, y12)
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

thickwall([p1, p2]; parts=[window(0.19, 0.49)])
thickwall([p1, p7]; parts=[window(0.25, 1.28)])
thickwall([p2, p3]; parts=[window(0.34, 0.57)])
thinwall([p2, p9])
thickwall([p3, p4]; parts=[window(0.77, 0.57), window(3.6, 0.49)])
thinwall([p3, p10])
thickwall([p4, p12]; parts=[window(0.28, 1.28)])
thinwall([p7, p8])
thickwall([p7, p15]; parts=[door(0.27, 1.25, rr)])
thinwall([p8, p9]; parts=[door(0.25, 0.71, rf)])
thinwall([p8, p16]; parts=[door(0.68, 0.79, rr)])
thinwall([p9, p10]; parts=[door(1.16, 0.71, lr)])
thinwall([p10, p11]; parts=[door(0.22, 0.71, lf)])
thinwall([p11, p12])
thinwall([p11, p18]; parts=[door(0.82, 0.71, lf)])
thickwall([p12, p21]; parts=[window(1.2, 1.96)])
thickwall([p14, p15]; parts=[window(0.6, 0.82)])
thickwall([p14, p22]; parts=[window(0.77, 2.73)])
thinwall([p15, p16])
thinwall([p17, p18])
thinwall([p17, p19])
thinwall([p18, p20])
thinwall([p19, p20]; parts=[door(0.82, 0.55, lf)])
thinwall([p19, p26]; parts=[door(0.19, 0.71, lf)])
thinwall([p20, p21])
thinwall([p21, p28]; parts=[window(1.75, 1.28)])
thinwall([p22, p23])
thickwall([p22, p24]; parts=[window(0.26, 0.7)])
thinwall([p23, p25])
thinwall([p24, p30]; parts=[window(0.28, 1.09)])
thinwall([p26, p27])
thickwall([p27, p28]; parts=[window(0.44, 0.49)])
thickwall([p27, p35]; parts=[window(0.5, 1.09), door(2.84, 0.79, rf)])
thickwall([p30, p31]; parts=[window(0.21, 0.7)])
thickwall([p31, p42]; parts=[window(2.56, 1.28)])
thinwall([p32, p33])
thinwall([p33, p34])
thinwall([p33, p39])
thinwall([p34, p35]; parts=[door(0.42, 0.79, lf)])
thinwall([p34, p41]; parts=[door(0.47, 0.55, lf)])
thickwall([p35, p52]; parts=[window(2.15, 1.09)])
thinwall([p38, p39])
thinwall([p38, p43])
thinwall([p39, p40])
thinwall([p40, p41])
thinwall([p40, p45])
thickwall([p42, p43]; parts=[window(0.24, 2.73), door(3.57, 0.71, rr)])
thickwall([p43, p44]; parts=[window(0.38, 0.49)])
thinwall([p44, p45]; parts=[door(0.34, 0.55, lr)])
thinwall([p44, p50]; parts=[window(0.38, 0.49)])
thinwall([p45, p46])
thinwall([p46, p51]; parts=[door(0.21, 0.71, lr)])
thickwall([p50, p51])
thickwall([p51, p52]; parts=[door(0.36, 0.79, rr)])

##

railing([p5, p6], 0.05)
railing([p6, p13], 0.05)
railing([p28, p29], 0.05)
railing([p29, p37], 0.05)
railing([p36, p37], 0.05)
railing([p42, p47], 0.05)
railing([p47, p48], 0.05)
railing([p49, p53], 0.05)

##

closet(xy(7.04, 4.45), xy(6.35, 6.03))
closet(xy(9.05, 8.7), xy(8.84, 8.37))
closet(xy(12.19, 8.32), xy(10.2, 8.95))
closet(xy(3.58, 9.87), xy(1.47, 9.28))
closet(xy(21.47, 9.53), xy(21.13, 10.01))
closet(xy(19.72, 10.23), xy(17.56, 9.63))
closet(xy(9.08, 9.85), xy(8.62, 10.23))
closet(xy(7.04, 8.21), xy(6.38, 10.25))
closet(xy(21.05, 12.05), xy(20.78, 12.14))
closet(xy(18.19, 11.56), xy(16.88, 12.16))
closet(xy(21.46, 11.59), xy(19.69, 12.19))
closet(xy(5.35, 10.45), xy(4.75, 13.31))
toilet(xy(17.03, 8.67), 0)
toilet(xy(2.81, 8.73), 180)
sink(xy(3.87, 8.86), 180)
sink(xy(16.47, 9.65), 270)
sink(xy(12.67, 9.86), 270)

##

xnames = [n for n = names(Main) if occursin(r"^x\d+$", string(n))]
ynames = [n for n = names(Main) if occursin(r"^y\d+$", string(n))]

show_x_lines(xnames, ynames; labels_only=false)
show_y_lines(ynames, xnames; labels_only=false)
show_points([n for n = names(Main) if occursin(r"^p\d+$", string(n))])
