import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriBlender", url="https://github.com/aptmcl/KhepriBlender.jl"))
##

using KhepriBlender: xy, delete_all_shapes
include("OutAux.jl")
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

wall1 = mywall([p1, p2], 0.3, parts=[mywindow(0.27, 0.53)])
wall2 = mywall([p1, p5], 0.3, parts=[mywindow(0.3, 1.36)])
wall3 = mywall([p2, p3], 0.3, parts=[mywindow(0.41, 0.53)])
wall4 = mywall([p2, p7], 0.15)
wall5 = mywall([p3, p4], 0.3, parts=[mywindow(0.87, 0.53), mywindow(3.99, 0.53)])
wall6 = mywall([p3, p8], 0.15)
wall7 = mywall([p4, p10], 0.3, parts=[mywindow(0.3, 1.36)])
wall8 = mywall([p5, p6], 0.15)
wall9 = mywall([p5, p12], 0.3, parts=[mydoor(0.3, 1.35)])
wall10 = mywall([p6, p7], 0.15, parts=[mydoor(0.3, 0.75)])
wall11 = mywall([p6, p13], 0.15, parts=[mydoor(0.78, 0.84)])
wall12 = mywall([p7, p8], 0.15, parts=[mydoor(1.28, 0.75)])
wall13 = mywall([p8, p9], 0.15, parts=[mydoor(0.27, 0.75)])
wall14 = mywall([p9, p10], 0.15)
wall15 = mywall([p9, p15], 0.15, parts=[mydoor(0.91, 0.75)])
wall16 = mywall([p10, p18], 0.3, parts=[mywindow(1.35, 2.1)])
wall17 = mywall([p11, p12], 0.3, parts=[mywindow(0.66, 0.87)])
wall18 = mywall([p11, p19], 0.3, parts=[mywindow(0.85, 2.97)])
wall19 = mywall([p12, p13], 0.3)
wall20 = mywall([p14, p15], 0.15)
wall21 = mywall([p14, p16], 0.15)
wall22 = mywall([p15, p17], 0.15)
wall23 = mywall([p16, p17], 0.15, parts=[mydoor(0.93, 0.6)])
wall24 = mywall([p16, p23], 0.15, parts=[mydoor(0.24, 0.75)])
wall25 = mywall([p17, p18], 0.15)
wall26 = mywall([p18, p25], 0.3, parts=[mywindow(1.92, 1.36)])
wall27 = mywall([p19, p20], 0.15)
wall28 = mywall([p19, p21], 0.3, parts=[mywindow(0.3, 0.76)])
wall29 = mywall([p20, p22], 0.15)
wall30 = mywall([p21, p26], 0.3, parts=[mywindow(0.35, 1.14)])
wall31 = mywall([p23, p24], 0.15)
wall32 = mywall([p24, p25], 0.3, parts=[mywindow(0.51, 0.53)])
wall33 = mywall([p24, p30], 0.3, parts=[mywindow(0.59, 1.14), mydoor(3.17, 0.84)])
wall34 = mywall([p26, p27], 0.3, parts=[mywindow(0.34, 0.53)])
wall35 = mywall([p27, p35], 0.3, parts=[mywindow(2.82, 1.36)])
wall36 = mywall([p28, p29], 0.15)
wall37 = mywall([p28, p32], 0.15)
wall38 = mywall([p29, p30], 0.15, parts=[mydoor(0.52, 0.75)])
wall39 = mywall([p29, p34], 0.15, parts=[mydoor(0.52, 0.6)])
wall40 = mywall([p30, p42], 0.3, parts=[mywindow(2.37, 1.14)])
wall41 = mywall([p31, p32], 0.15)
wall42 = mywall([p31, p36], 0.15)
wall43 = mywall([p32, p33], 0.15)
wall44 = mywall([p33, p34], 0.15)
wall45 = mywall([p33, p38], 0.15)
wall46 = mywall([p35, p36], 0.3, parts=[mywindow(0.27, 2.97), mydoor(3.93, 0.75)])
wall47 = mywall([p36, p37], 0.3, parts=[mywindow(0.42, 0.53)])
wall48 = mywall([p37, p38], 0.15, parts=[mydoor(0.43, 0.48)])
wall49 = mywall([p37, p40], 0.3, parts=[mywindow(0.42, 0.42)])
wall50 = mywall([p38, p39], 0.15)
wall51 = mywall([p39, p41], 0.15, parts=[mydoor(0.23, 0.75)])
wall52 = mywall([p40, p41], 0.3)
wall53 = mywall([p41, p42], 0.3, parts=[mydoor(0.43, 0.84)])

##

show_x_lines([n for n = names(Main) if startswith(string(n), "x")])
show_y_lines([n for n = names(Main) if startswith(string(n), "y")])
show_points([n for n = names(Main) if startswith(string(n), "p")])
