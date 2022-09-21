import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
# Pkg.add(Pkg.PackageSpec(name="KhepriBlender", url="https://github.com/aptmcl/KhepriBlender.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

using KhepriAutoCAD: xy, xyz, delete_all_shapes, regular_prism
include("OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.15; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.3; parts=parts)

x1 = 1.41
x2 = 5.13
x3 = 7.79
x4 = 10.08
x5 = 12.69
x6 = 13.58
x7 = 15.24
x8 = 16.14
x9 = 17.85
x10 = 19.23
x11 = 20.61
x12 = 21.78
x13 = 23.79

y1 = 1.56
y2 = 2.61
y3 = 4.71
y4 = 6.72
y5 = 8.06
y6 = 9.03
y7 = 10.11
y8 = 10.5
y9 = 11.27
y10 = 13.59
y11 = 14.85

p1 = xy(x1, y3)
p2 = xy(x1, y5)
p3 = xy(x1, y7)
p4 = xy(x1, y11)
p5 = xy(x2, y3)
p6 = xy(x2, y4)
p7 = xy(x2, y5)
p8 = xy(x2, y7)
p9 = xy(x2, y9)
p10 = xy(x2, y11)
p11 = xy(x3, y2)
p12 = xy(x3, y3)
p13 = xy(x3, y4)
p14 = xy(x3, y6)
p15 = xy(x3, y9)
p16 = xy(x4, y6)
p17 = xy(x4, y9)
p18 = xy(x4, y11)
p19 = xy(x5, y2)
p20 = xy(x5, y4)
p21 = xy(x6, y1)
p22 = xy(x6, y4)
p23 = xy(x6, y6)
p24 = xy(x6, y10)
p25 = xy(x6, y11)
p26 = xy(x7, y1)
p27 = xy(x8, y2)
p28 = xy(x9, y6)
p29 = xy(x9, y9)
p30 = xy(x9, y10)
p31 = xy(x10, y5)
p32 = xy(x10, y6)
p33 = xy(x10, y8)
p34 = xy(x10, y9)
p35 = xy(x11, y2)
p36 = xy(x11, y5)
p37 = xy(x12, y5)
p38 = xy(x12, y8)
p39 = xy(x12, y9)
p40 = xy(x13, y5)
p41 = xy(x13, y9)
p42 = xy(x13, y10)

##

delete_all_shapes()

wall1 = thickwall([p1, p2]; parts=[window(0.27, 0.53)])
wall2 = thickwall([p1, p5]; parts=[window(0.3, 1.36)])
wall3 = thickwall([p2, p3]; parts=[window(0.41, 0.53)])
wall4 = thinwall([p2, p7])
wall5 = thickwall([p3, p4]; parts=[window(0.87, 0.53), mywindow(3.99, 0.53)])
wall6 = thinwall([p3, p8])
wall7 = thickwall([p4, p10]; parts=[window(0.3, 1.36)])
wall8 = thinwall([p5, p6])
wall9 = thickwall([p5, p12]; parts=[door(0.3, 1.35)])
wall10 = thinwall([p6, p7]; parts=[door(0.3, 0.75)])
wall11 = thinwall([p6, p13]; parts=[door(0.78, 0.84)])
wall12 = thinwall([p7, p8]; parts=[door(1.28, 0.75)])
wall13 = thinwall([p8, p9]; parts=[door(0.27, 0.75)])
wall14 = thinwall([p9, p10])
wall15 = thinwall([p9, p15]; parts=[door(0.91, 0.75)])
wall16 = thickwall([p10, p18]; parts=[window(1.35, 2.1)])
wall17 = thickwall([p11, p12]; parts=[window(0.66, 0.87)])
wall18 = thickwall([p11, p19]; parts=[window(0.85, 2.97)])
wall19 = thickwall([p12, p13])
wall20 = thinwall([p14, p15])
wall21 = thinwall([p14, p16])
wall22 = thinwall([p15, p17])
wall23 = thinwall([p16, p17]; parts=[door(0.93, 0.6)])
wall24 = thinwall([p16, p23]; parts=[door(0.24, 0.75)])
wall25 = thinwall([p17, p18])
wall26 = thickwall([p18, p25]; parts=[window(1.92, 1.36)])
wall27 = thinwall([p19, p20])
wall28 = thickwall([p19, p21]; parts=[window(0.3, 0.76)])
wall29 = thinwall([p20, p22])
wall30 = thickwall([p21, p26]; parts=[window(0.35, 1.14)])
wall31 = thinwall([p23, p24])
wall32 = thickwall([p24, p25]; parts=[window(0.51, 0.53)])
wall33 = thickwall([p24, p30]; parts=[window(0.59, 1.14), door(3.17, 0.84)])
wall34 = thickwall([p26, p27]; parts=[window(0.34, 0.53)])
wall35 = thickwall([p27, p35]; parts=[window(2.82, 1.36)])
wall36 = thinwall([p28, p29])
wall37 = thinwall([p28, p32])
wall38 = thinwall([p29, p30]; parts=[door(0.52, 0.75)])
wall39 = thinwall([p29, p34]; parts=[door(0.52, 0.6)])
wall40 = thickwall([p30, p42]; parts=[window(2.37, 1.14)])
wall41 = thinwall([p31, p32])
wall42 = thinwall([p31, p36])
wall43 = thinwall([p32, p33])
wall44 = thinwall([p33, p34])
wall45 = thinwall([p33, p38])
wall46 = thickwall([p35, p36]; parts=[window(0.27, 2.97), door(3.93, 0.75)])
wall47 = thickwall([p36, p37]; parts=[window(0.42, 0.53)])
wall48 = thinwall([p37, p38]; parts=[door(0.43, 0.48)])
wall49 = thickwall([p37, p40]; parts=[window(0.42, 0.42)])
wall50 = thinwall([p38, p39])
wall51 = thinwall([p39, p41]; parts=[door(0.23, 0.75)])
wall52 = thickwall([p40, p41])
wall53 = thickwall([p41, p42]; parts=[door(0.43, 0.84)])

##

namesx = [n for n = names(Main) if startswith(string(n), "x")]
namesy = [n for n = names(Main) if startswith(string(n), "y")]

show_x_lines(namesx, namesy)
show_y_lines(namesy, namesx)
show_points([n for n = names(Main) if startswith(string(n), "p")])
