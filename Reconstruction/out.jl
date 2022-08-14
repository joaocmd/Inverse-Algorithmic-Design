import Pkg
Pkg.add(Pkg.PackageSpec(name = "KhepriBase", url = "https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name = "KhepriBlender", url = "https://github.com/aptmcl/KhepriBlender.jl"))
##

using KhepriBlender: xy, delete_all_shapes
include("OutAux.jl")
x1 = 4.7
x2 = 17.1
x3 = 25.97
x4 = 33.6
x5 = 42.3
x6 = 44.9
x7 = 45.4
x8 = 50.8
x9 = 53.8
x10 = 59.5
x11 = 64.1
x12 = 68.7
x13 = 72.6
x14 = 79.3

y1 = -28.5
y2 = -25.0
y3 = -18.0
y4 = -11.3
y5 = -6.85
y6 = -3.6
y7 = 0.0
y8 = 1.3
y9 = 3.5
y10 = 4.3
y11 = 11.6
y12 = 15.8

p1 = xy(x1, y3)
p2 = xy(x1, y5)
p3 = xy(x1, y7)
p4 = xy(x1, y12)
p5 = xy(x2, y3)
p6 = xy(x2, y4)
p7 = xy(x2, y5)
p8 = xy(x2, y7)
p9 = xy(x2, y10)
p10 = xy(x2, y12)
p11 = xy(x3, y2)
p12 = xy(x3, y3)
p13 = xy(x3, y4)
p14 = xy(x3, y6)
p15 = xy(x3, y10)
p16 = xy(x4, y6)
p17 = xy(x4, y10)
p18 = xy(x4, y12)
p19 = xy(x5, y2)
p20 = xy(x5, y4)
p21 = xy(x6, y4)
p22 = xy(x6, y6)
p23 = xy(x7, y1)
p24 = xy(x7, y11)
p25 = xy(x7, y12)
p26 = xy(x8, y1)
p27 = xy(x9, y2)
p28 = xy(x10, y6)
p29 = xy(x10, y9)
p30 = xy(x10, y11)
p31 = xy(x11, y5)
p32 = xy(x11, y6)
p33 = xy(x11, y8)
p34 = xy(x11, y9)
p35 = xy(x12, y2)
p36 = xy(x12, y5)
p37 = xy(x13, y5)
p38 = xy(x13, y8)
p39 = xy(x13, y9)
p40 = xy(x14, y5)
p41 = xy(x14, y9)
p42 = xy(x14, y11)

##

delete_all_shapes()

wall1 = mywall([p1, p2], 0.2, parts = [mywindow(0.9, 1.7)])
wall2 = mywall([p1, p5], 1.8, parts = [mywindow(1.0, 4.45)])
wall3 = mywall([p2, p3], 2.9, parts = [mywindow(1.35, 1.95)])
wall4 = mywall([p2, p7], 2.9)
wall5 = mywall([p3, p4], 2.9, parts = [mywindow(13.3, 1.7), mywindow(2.9, 1.95)])
wall6 = mywall([p3, p8], 2.9)
wall7 = mywall([p4, p10], 1.8, parts = [mywindow(1.0, 4.65)])
wall8 = mywall([p5, p6], 1.05)
wall9 = mywall([p5, p12], 2.9, parts = [mydoor(1.0, 4.5)])
wall10 = mywall([p6, p7], 2.9, parts = [mydoor(1.0, 2.35)])
wall11 = mywall([p6, p13], 2.9, parts = [mydoor(2.6, 2.75)])
wall12 = mywall([p7, p8], 2.9, parts = [mydoor(4.25, 2.5)])
wall13 = mywall([p8, p9], 2.9, parts = [mydoor(0.9, 2.5)])
wall14 = mywall([p9, p10], 1.05)
wall15 = mywall([p9, p15], 2.9, parts = [mydoor(3.0, 2.5)])
wall16 = mywall([p10, p18], 1.8, parts = [mywindow(4.5, 7.0)])
wall17 = mywall([p11, p12], 2.9, parts = [mywindow(2.2, 2.9)])
wall18 = mywall([p11, p19], 0.2, parts = [mywindow(2.84, 9.9)])
wall19 = mywall([p12, p13], 2.9)
wall20 = mywall([p14, p15], 2.9)
wall21 = mywall([p14, p16], 2.9)
wall22 = mywall([p15, p17], 2.9)
wall23 = mywall([p16, p17], 2.9, parts = [mydoor(3.1, 1.9)])
wall24 = mywall([p16, p22], 2.9, parts = [mydoor(0.81, 2.35)])
wall25 = mywall([p17, p18], 2.9)
wall26 = mywall([p18, p25], 0.2, parts = [mywindow(6.4, 4.45)])
wall27 = mywall([p19, p20], 2.9)
wall28 = mywall([p19, p23], 1.05, parts = [mywindow(1.02, 2.54)])
wall29 = mywall([p20, p21], 2.9)
wall30 = mywall([p22, p24], 2.9)
wall31 = mywall([p23, p26], 1.05, parts = [mywindow(1.01, 3.75)])
wall32 = mywall([p24, p25], 2.9, parts = [mywindow(1.7, 1.7)])
wall33 = mywall([p24, p30], 1.8, parts = [mywindow(1.8, 3.75), mydoor(10.4, 2.75)])
wall34 = mywall([p26, p27], 0.2, parts = [mywindow(1.14, 1.7)])
wall35 = mywall([p27, p35], 2.9, parts = [mywindow(9.4, 4.65)])
wall36 = mywall([p28, p29], 1.8)
wall37 = mywall([p28, p32], 2.9)
wall38 = mywall([p29, p30], 1.8, parts = [mydoor(2.1, 2.5)])
wall39 = mywall([p29, p34], 1.05, parts = [mydoor(1.7, 2.1)])
wall40 = mywall([p30, p42], 1.8, parts = [mywindow(7.9, 4.0)])
wall41 = mywall([p31, p32], 2.9)
wall42 = mywall([p31, p36], 1.05)
wall43 = mywall([p32, p33], 2.9)
wall44 = mywall([p33, p34], 0.2)
wall45 = mywall([p33, p38], 2.9)
wall46 = mywall([p35, p36], 2.9, parts = [mydoor(13.1, 2.5), mywindow(0.9, 9.9)])
wall47 = mywall([p36, p37], 0.2, parts = [mywindow(1.4, 1.7)])
wall48 = mywall([p37, p38], 1.8, parts = [mydoor(1.45, 1.6)])
wall49 = mywall([p37, p40], 1.8, parts = [mywindow(1.4, 1.4)])
wall50 = mywall([p38, p39], 2.9)
wall51 = mywall([p39, p41], 2.9, parts = [mydoor(0.71, 2.5)])
wall52 = mywall([p40, p41], 1.8)
wall53 = mywall([p41, p42], 2.9, parts = [mydoor(1.8, 2.9)])

##

show_x_lines([n for n = names(Main) if startswith(string(n), "x")])
show_y_lines([n for n = names(Main) if startswith(string(n), "y")])
show_points([n for n = names(Main) if startswith(string(n), "p")])
