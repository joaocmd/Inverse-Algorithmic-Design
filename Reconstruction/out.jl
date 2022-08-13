import Pkg
Pkg.add(Pkg.PackageSpec(name = "KhepriBase", url = "https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name = "KhepriBlender", url = "https://github.com/aptmcl/KhepriBlender.jl"))
##

using KhepriBlender: xy, delete_all_shapes
include("OutAux.jl")
x1 = 4.8
x2 = 17.3
x3 = 26.3
x4 = 33.7
x5 = 42.3
x6 = 45.6
x7 = 50.8
x8 = 53.8
x9 = 59.6
x10 = 64.3
x11 = 68.7
x12 = 72.6
x13 = 79.4

y1 = -28.5
y2 = -25.2
y3 = -18.1
y4 = -11.4
y5 = -7.1
y6 = -3.8
y7 = 0.0
y8 = 1.2
y9 = 3.5
y10 = 4.2
y11 = 11.4
y12 = 15.6

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
p21 = xy(x6, y1)
p22 = xy(x6, y4)
p23 = xy(x6, y6)
p24 = xy(x6, y11)
p25 = xy(x6, y12)
p26 = xy(x7, y1)
p27 = xy(x8, y2)
p28 = xy(x9, y6)
p29 = xy(x9, y9)
p30 = xy(x9, y11)
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
p42 = xy(x13, y11)

##

delete_all_shapes()

wall1 = mywall([p1, p2], parts = [mywindow(1.0, 1.7)])
wall2 = mywall([p1, p5], parts = [mywindow(0.91, 4.5)])
wall3 = mywall([p2, p3], parts = [mywindow(1.6, 2.0)])
wall4 = mywall([p2, p7])
wall5 = mywall([p3, p4], parts = [mywindow(2.9, 1.9), mywindow(13.3, 1.7)])
wall6 = mywall([p3, p8])
wall7 = mywall([p4, p10], parts = [mywindow(0.91, 4.7)])
wall8 = mywall([p5, p6])
wall9 = mywall([p5, p12], parts = [mydoor(0.81, 4.5)])
wall10 = mywall([p6, p7], parts = [mydoor(1.14, 2.4)])
wall11 = mywall([p6, p13], parts = [mydoor(2.4, 2.7)])
wall12 = mywall([p7, p8], parts = [mydoor(4.51, 2.6)])
wall13 = mywall([p8, p9], parts = [mydoor(0.92, 2.5)])
wall14 = mywall([p9, p10])
wall15 = mywall([p9, p15], parts = [mydoor(2.8, 2.5)])
wall16 = mywall([p10, p18], parts = [mywindow(4.3, 7.0)])
wall17 = mywall([p11, p12], parts = [mywindow(2.44, 2.9)])
wall18 = mywall([p11, p19], parts = [mywindow(2.52, 9.9)])
wall19 = mywall([p12, p13])
wall20 = mywall([p14, p15])
wall21 = mywall([p14, p16])
wall22 = mywall([p15, p17])
wall23 = mywall([p16, p17], parts = [mydoor(3.3, 1.9)])
wall24 = mywall([p16, p23], parts = [mydoor(0.76, 2.3)])
wall25 = mywall([p17, p18])
wall26 = mywall([p18, p25], parts = [mywindow(6.3, 4.4)])
wall27 = mywall([p19, p20])
wall28 = mywall([p19, p21], parts = [mywindow(0.85, 2.54)])
wall29 = mywall([p20, p22])
wall30 = mywall([p21, p26], parts = [mywindow(0.81, 3.7)])
wall31 = mywall([p23, p24])
wall32 = mywall([p24, p25], parts = [mywindow(1.92, 1.7)])
wall33 = mywall([p24, p30], parts = [mywindow(1.62, 3.8), mydoor(10.2, 2.8)])
wall34 = mywall([p26, p27], parts = [mywindow(1.14, 1.75)])
wall35 = mywall([p27, p35], parts = [mywindow(9.4, 4.6)])
wall36 = mywall([p28, p29])
wall37 = mywall([p28, p32])
wall38 = mywall([p29, p30], parts = [mydoor(2.11, 2.5)])
wall39 = mywall([p29, p34], parts = [mydoor(1.6, 2.1)])
wall40 = mywall([p30, p42], parts = [mywindow(7.81, 4.0)])
wall41 = mywall([p31, p32])
wall42 = mywall([p31, p36])
wall43 = mywall([p32, p33])
wall44 = mywall([p33, p34])
wall45 = mywall([p33, p38])
wall46 = mywall([p35, p36], parts = [mywindow(1.1, 9.9), mydoor(13.3, 2.6)])
wall47 = mywall([p36, p37], parts = [mywindow(1.42, 1.8)])
wall48 = mywall([p37, p38], parts = [mydoor(1.7, 1.6)])
wall49 = mywall([p37, p40], parts = [mywindow(1.41, 1.4)])
wall50 = mywall([p38, p39])
wall51 = mywall([p39, p41], parts = [mydoor(0.71, 2.5)])
wall52 = mywall([p40, p41])
wall53 = mywall([p41, p42], parts = [mydoor(1.8, 2.9)])

##

show_x_lines([n for n = names(Main) if startswith(string(n), "x")])
show_y_lines([n for n = names(Main) if startswith(string(n), "y")])
show_points([n for n = names(Main) if startswith(string(n), "p")])
