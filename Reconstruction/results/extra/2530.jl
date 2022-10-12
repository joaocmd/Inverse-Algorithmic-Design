import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

# include("OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.11; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.31; parts=parts)

x1 = 3.11
x2 = 4.8
x3 = 5.86
x4 = 6.26
x5 = 7.86
x6 = 8.54
x7 = 11.29
x8 = 14.49
x9 = 16.26
x10 = 17.8
x11 = 20.31
x12 = 21.26

y1 = 1.63
y2 = 2.8
y3 = 4.91
y4 = 5.29
y5 = 6.2
y6 = 7.62
y7 = 8.34
y8 = 9.4
y9 = 9.86
y10 = 10.98
y11 = 13.4

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
thickwall([p1, p15]; parts=[window(1.03, 0.41)])
thickwall([p2, p3]; parts=[door(0.1, 0.83)])
thinwall([p2, p10]; parts=[door(1.89, 0.63, lr)])
thickwall([p3, p4])
thinwall([p3, p7])
thickwall([p4, p5])
thinwall([p4, p8])
thickwall([p5, p6])
thinwall([p5, p9])
thickwall([p6, p13])
thinwall([p7, p8])
thinwall([p7, p11])
thinwall([p8, p9]; parts=[door(0.37, 0.63, rr)])
thinwall([p9, p12])
thinwall([p10, p14])
thinwall([p11, p20]; parts=[door(1.4, 0.36, rf)])
thinwall([p12, p13]; parts=[door(0.42, 0.63, rf)])
thinwall([p13, p18])
thinwall([p14, p16])
thinwall([p15, p16])
thickwall([p15, p24]; parts=[window(0.83, 0.41), window(4.11, 1.59)])
thinwall([p16, p19])
thinwall([p17, p18])
thinwall([p17, p21])
thickwall([p18, p23]; parts=[door(0.86, 0.76, rf)])
thinwall([p19, p20])
thinwall([p19, p28])
thinwall([p20, p21]; parts=[door(0.49, 0.76, lf)])
thinwall([p22, p23])
thickwall([p23, p43]; parts=[window(1.8, 3.46), window(5.34, 1.69)])
thickwall([p24, p25])
thinwall([p25, p26])
thickwall([p25, p29]; parts=[door(0.71, 0.83, rr)])
thinwall([p26, p27])
thinwall([p26, p30])
thinwall([p27, p28])
thinwall([p29, p30])
thickwall([p29, p34])
thinwall([p30, p35])
thinwall([p31, p32])
thinwall([p32, p38])
thickwall([p33, p34])
thickwall([p33, p40]; parts=[window(0.89, 1.59)])
thinwall([p34, p35])
thickwall([p35, p36])
thinwall([p36, p37]; parts=[door(0.24, 0.36, rr)])
thinwall([p37, p38])
thinwall([p37, p39])
thinwall([p38, p42])
thinwall([p39, p41])
thickwall([p40, p41])
thickwall([p41, p42])
thickwall([p42, p43])


##

closet(xy(17.63, 4.26), xy(17.43, 4.37))
closet(xy(7.78, 4.27), xy(7.26, 4.74))
closet(xy(19.51, 6.37), xy(19.11, 6.74))
closet(xy(6.37, 7.23), xy(6.11, 6.51))
closet(xy(6.8, 6.31), xy(5.86, 7.49))
closet(xy(8.43, 6.31), xy(7.94, 7.51))
closet(xy(17.66, 8.23), xy(16.34, 7.83))
closet(xy(21.06, 8.26), xy(20.43, 6.34))
closet(xy(8.43, 10.31), xy(8.0, 10.94))
sink(xy(16.73, 3.26), 0)
sink(xy(17.54, 4.49), 90)
sink(xy(4.3, 8.9), 180)
sink(xy(6.44, 10.64), 180)
sink(xy(8.26, 12.33), 270)

##

show_auxiliary_labels(labels_only=false)
