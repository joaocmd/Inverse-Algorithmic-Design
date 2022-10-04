import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

using KhepriAutoCAD: xy, delete_all_shapes
include("OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.3; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.67; parts=parts)

x1 = 2.14
x2 = 9.38
x3 = 9.93
x4 = 12.83
x5 = 13.28
x6 = 17.17
x7 = 21.62
x8 = 28.84
x9 = 42.87
x10 = 46.41
x11 = 48.84
x12 = 49.84
x13 = 52.68
x14 = 53.84
x15 = 57.31
x16 = 57.67
x17 = 59.81
x18 = 63.15
x19 = 64.8
x20 = 68.09
x21 = 69.98
x22 = 72.41
x23 = 75.03
x24 = 80.21
x25 = 85.26
x26 = 89.95
x27 = 91.72
x28 = 95.31
x29 = 98.6

y1 = 1.1
y2 = 6.94
y3 = 7.92
y4 = 8.47
y5 = 9.38
y6 = 9.74
y7 = 10.9
y8 = 12.06
y9 = 12.85
y10 = 13.46
y11 = 15.61
y12 = 16.87
y13 = 18.88
y14 = 19.37
y15 = 19.85
y16 = 20.93
y17 = 22.23
y18 = 23.3
y19 = 24.3
y20 = 26.25
y21 = 28.08
y22 = 30.0
y23 = 30.63
y24 = 32.27
y25 = 39.34

p1 = xy(x1, y1)
p2 = xy(x1, y7)
p3 = xy(x1, y18)
p4 = xy(x1, y23)
p5 = xy(x1, y25)
p6 = xy(x2, y1)
p7 = xy(x2, y4)
p8 = xy(x2, y5)
p9 = xy(x3, y7)
p10 = xy(x3, y8)
p11 = xy(x3, y15)
p12 = xy(x3, y16)
p13 = xy(x3, y17)
p14 = xy(x3, y18)
p15 = xy(x3, y20)
p16 = xy(x3, y23)
p17 = xy(x3, y24)
p18 = xy(x3, y25)
p19 = xy(x4, y4)
p20 = xy(x4, y7)
p21 = xy(x4, y8)
p22 = xy(x4, y15)
p23 = xy(x4, y16)
p24 = xy(x4, y18)
p25 = xy(x4, y21)
p26 = xy(x4, y22)
p27 = xy(x4, y24)
p28 = xy(x5, y4)
p29 = xy(x6, y21)
p30 = xy(x6, y22)
p31 = xy(x7, y1)
p32 = xy(x7, y4)
p33 = xy(x7, y16)
p34 = xy(x7, y18)
p35 = xy(x7, y22)
p36 = xy(x7, y24)
p37 = xy(x7, y25)
p38 = xy(x8, y24)
p39 = xy(x8, y25)
p40 = xy(x9, y24)
p41 = xy(x9, y25)
p42 = xy(x10, y24)
p43 = xy(x10, y25)
p44 = xy(x11, y2)
p45 = xy(x11, y18)
p46 = xy(x12, y8)
p47 = xy(x12, y11)
p48 = xy(x12, y18)
p49 = xy(x12, y22)
p50 = xy(x12, y24)
p51 = xy(x12, y25)
p52 = xy(x13, y2)
p53 = xy(x13, y6)
p54 = xy(x13, y7)
p55 = xy(x13, y8)
p56 = xy(x13, y10)
p57 = xy(x14, y21)
p58 = xy(x15, y11)
p59 = xy(x15, y16)
p60 = xy(x15, y18)
p61 = xy(x16, y21)
p62 = xy(x16, y22)
p63 = xy(x17, y11)
p64 = xy(x17, y16)
p65 = xy(x18, y11)
p66 = xy(x18, y12)
p67 = xy(x18, y14)
p68 = xy(x18, y16)
p69 = xy(x19, y11)
p70 = xy(x19, y12)
p71 = xy(x19, y14)
p72 = xy(x19, y16)
p73 = xy(x19, y19)
p74 = xy(x19, y22)
p75 = xy(x20, y22)
p76 = xy(x20, y24)
p77 = xy(x20, y25)
p78 = xy(x21, y9)
p79 = xy(x21, y11)
p80 = xy(x22, y9)
p81 = xy(x23, y11)
p82 = xy(x24, y9)
p83 = xy(x24, y11)
p84 = xy(x25, y9)
p85 = xy(x25, y11)
p86 = xy(x26, y9)
p87 = xy(x26, y11)
p88 = xy(x26, y13)
p89 = xy(x27, y11)
p90 = xy(x28, y2)
p91 = xy(x28, y3)
p92 = xy(x28, y9)
p93 = xy(x28, y11)
p94 = xy(x28, y13)
p95 = xy(x28, y19)
p96 = xy(x29, y3)
p97 = xy(x29, y11)

##

delete_all_shapes()

thickwall([p1, p2]; parts=[window(0.86, 1.28), window(2.93, 1.58), window(5.3, 1.58), window(7.8, 1.34)])
thickwall([p1, p6])
thickwall([p2, p3]; parts=[window(0.43, 1.46), window(2.86, 1.34), window(5.42, 1.28), window(7.73, 1.58), window(10.41, 1.34)])
thinwall([p2, p9])
thickwall([p3, p4]; parts=[window(0.52, 1.16), window(2.71, 1.74), window(5.33, 1.46)])
thinwall([p3, p14])
thickwall([p4, p5]; parts=[window(0.45, 1.46), window(2.87, 1.83), window(5.61, 1.83)])
thinwall([p4, p16])
thickwall([p5, p18])
thinwall([p6, p7])
thickwall([p6, p31]; parts=[window(0.5, 1.34), window(2.86, 1.28), window(5.42, 0.73), window(7.73, 1.28), window(10.23, 0.97)])
thinwall([p7, p8])
thinwall([p7, p19])
thinwall([p8, p9])
thinwall([p9, p10])
thickwall([p11, p12])
thinwall([p12, p13])
thickwall([p13, p14])
thickwall([p14, p15])
thinwall([p15, p16])
thinwall([p17, p18])
thinwall([p17, p27])
thickwall([p18, p37]; parts=[window(0.43, 1.83), window(2.86, 1.74), window(5.24, 1.58), window(7.49, 1.46), window(9.87, 1.34)])
thinwall([p19, p28])
thinwall([p20, p21])
thinwall([p20, p28])
thinwall([p22, p23])
thinwall([p23, p24])
thinwall([p23, p33])
thinwall([p24, p34])
thinwall([p25, p29])
thinwall([p26, p30])
thinwall([p27, p36])
thinwall([p28, p32])
thinwall([p30, p35])
thickwall([p31, p32])
thickwall([p32, p33]; parts=[window(0.61, 1.16), window(2.86, 1.46), window(5.47, 1.28), window(7.85, 1.46), window(10.35, 1.34)])
thickwall([p33, p34])
thickwall([p34, p35])
thickwall([p37, p39]; parts=[window(0.55, 1.46), window(2.86, 1.58), window(5.3, 1.34)])
thickwall([p39, p41]; parts=[window(0.52, 1.16), window(2.71, 1.58), window(5.09, 1.34), window(7.46, 1.46), window(9.71, 1.46), window(12.09, 1.46)])
thinwall([p40, p41])
thickwall([p41, p43]; parts=[window(0.37, 1.58)])
thinwall([p42, p43])
thickwall([p43, p51]; parts=[window(1.46, 1.58)])
thinwall([p44, p45])
thinwall([p44, p52])
thinwall([p45, p48])
thinwall([p46, p55])
thinwall([p47, p58])
thickwall([p48, p60])
thinwall([p49, p62])
thinwall([p50, p51])
thickwall([p51, p77]; parts=[window(0.52, 1.34), window(2.77, 1.34), window(5.09, 1.34), window(9.53, 1.46), window(11.85, 1.46), window(13.98, 1.46), window(16.11, 1.46)])
thinwall([p52, p53])
thinwall([p53, p54])
thinwall([p54, p55])
thinwall([p55, p56])
thinwall([p58, p59])
thinwall([p58, p63])
thickwall([p59, p60]; parts=[door(0.76, 0.98)])
thinwall([p59, p64])
thinwall([p63, p64])
thinwall([p63, p93])
thinwall([p64, p68]; parts=[door(0.79, 0.79)])
thinwall([p65, p66])
thinwall([p65, p79])
thinwall([p66, p67])
thinwall([p66, p70])
thinwall([p67, p68])
thinwall([p67, p71])
thinwall([p68, p72])
thinwall([p69, p70])
thinwall([p70, p71]; parts=[door(0.62, 1.1)])
thinwall([p71, p72])
thickwall([p72, p73]; parts=[door(0.7, 0.79)])
thickwall([p73, p74])
thinwall([p73, p95])
thickwall([p74, p75])
thickwall([p75, p76])
thickwall([p76, p77])
thinwall([p78, p79])
thinwall([p78, p80])
thinwall([p81, p83])
thinwall([p82, p83])
thinwall([p82, p84])
thinwall([p83, p85])
thinwall([p84, p86])
thinwall([p85, p87])
thinwall([p86, p92])
thinwall([p87, p88])
thinwall([p87, p89])
thinwall([p88, p94])
thinwall([p89, p97])
thickwall([p90, p91])
thickwall([p91, p92])
thickwall([p91, p96])
thickwall([p92, p93]; parts=[door(0.92, 0.79)])
thickwall([p93, p94]; parts=[window(0.96, 1.46)])
thickwall([p94, p95])
thickwall([p96, p97])

railing([p38, p39], 0.15)
railing([p57, p61], 0.15)

xnames = [n for n = names(Main) if occursin(r"^x\d+$", string(n))]
ynames = [n for n = names(Main) if occursin(r"^y\d+$", string(n))]

show_x_lines(xnames, ynames; labels_only=true)
show_y_lines(ynames, xnames; labels_only=true)
show_points([n for n = names(Main) if occursin(r"^p\d+$", string(n))])

##

closet(xy(64.37, 20.28), xy(64.07, 20.58))
closet(xy(64.43, 20.1), xy(63.52, 20.58))

##