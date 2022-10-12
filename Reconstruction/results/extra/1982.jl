import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("../OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.2; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.3; parts=parts)

x1 = 2.8
x2 = 4.7
x3 = 5.3
x4 = 6.45
x5 = 7.65
x6 = 9.05
x7 = 10.55
x8 = 11.76
x9 = 13.5
x10 = 14.5
x11 = 14.95
x12 = 16.15
x13 = 17.45
x14 = 17.85
x15 = 19.05
x16 = 19.5
x17 = 20.75
x18 = 21.75
x19 = 23.5
x20 = 23.9
x21 = 24.5
x22 = 27.1
x23 = 30.5

y1 = 2.55
y2 = 9.15
y3 = 13.1
y4 = 14.45
y5 = 16.85
y6 = 20.45
y7 = 21.15
y8 = 22.85
y9 = 23.25
y10 = 24.0
y11 = 25.45
y12 = 28.1
y13 = 31.1
y14 = 32.65
y15 = 33.55
y16 = 35.2
y17 = 36.7
y18 = 37.25
y19 = 40.6
y20 = 42.05

p1 = xy(x1, y5)
p2 = xy(x1, y7)
p3 = xy(x1, y11)
p4 = xy(x1, y12)
p5 = xy(x2, y11)
p6 = xy(x2, y12)
p7 = xy(x3, y14)
p8 = xy(x3, y19)
p9 = xy(x4, y5)
p10 = xy(x4, y7)
p11 = xy(x4, y11)
p12 = xy(x4, y12)
p13 = xy(x5, y5)
p14 = xy(x5, y14)
p15 = xy(x5, y17)
p16 = xy(x5, y19)
p17 = xy(x6, y7)
p18 = xy(x6, y9)
p19 = xy(x6, y11)
p20 = xy(x6, y12)
p21 = xy(x7, y7)
p22 = xy(x7, y9)
p23 = xy(x8, y5)
p24 = xy(x8, y6)
p25 = xy(x8, y7)
p26 = xy(x8, y9)
p27 = xy(x8, y12)
p28 = xy(x8, y14)
p29 = xy(x8, y16)
p30 = xy(x8, y18)
p31 = xy(x8, y19)
p32 = xy(x9, y8)
p33 = xy(x9, y9)
p34 = xy(x9, y10)
p35 = xy(x10, y14)
p36 = xy(x10, y15)
p37 = xy(x11, y5)
p38 = xy(x11, y6)
p39 = xy(x11, y7)
p40 = xy(x11, y9)
p41 = xy(x11, y10)
p42 = xy(x12, y13)
p43 = xy(x12, y14)
p44 = xy(x12, y15)
p45 = xy(x12, y16)
p46 = xy(x13, y13)
p47 = xy(x13, y14)
p48 = xy(x13, y16)
p49 = xy(x14, y5)
p50 = xy(x14, y7)
p51 = xy(x15, y14)
p52 = xy(x15, y16)
p53 = xy(x15, y18)
p54 = xy(x15, y20)
p55 = xy(x16, y8)
p56 = xy(x16, y9)
p57 = xy(x16, y12)
p58 = xy(x17, y7)
p59 = xy(x17, y12)
p60 = xy(x18, y7)
p61 = xy(x19, y14)
p62 = xy(x20, y17)
p63 = xy(x20, y19)
p64 = xy(x20, y20)
p65 = xy(x21, y2)
p66 = xy(x21, y3)
p67 = xy(x21, y4)
p68 = xy(x21, y5)
p69 = xy(x21, y7)
p70 = xy(x21, y8)
p71 = xy(x21, y12)
p72 = xy(x22, y1)
p73 = xy(x22, y2)
p74 = xy(x22, y14)
p75 = xy(x22, y19)
p76 = xy(x23, y1)
p77 = xy(x23, y2)
p78 = xy(x23, y3)
p79 = xy(x23, y5)
p80 = xy(x23, y12)

##

delete_all_shapes()

thickwall([p1, p2])
thinwall([p1, p9]; parts=[door(1.5, 0.85, rr)])
thickwall([p2, p3])
thickwall([p3, p4])
thinwall([p3, p5])
thickwall([p4, p6])
thinwall([p5, p6])
thinwall([p6, p12])
thinwall([p7, p8])
thinwall([p7, p14])
thinwall([p8, p16])
thinwall([p9, p10])
thickwall([p9, p13])
thinwall([p10, p11])
thinwall([p10, p17])
thinwall([p11, p12])
thinwall([p11, p19])
thickwall([p12, p20]; parts=[window(1.25, 1.1)])
thinwall([p13, p23]; parts=[window(1.8, 1.9)])
thinwall([p14, p15])
thinwall([p14, p28]; parts=[window(1.45, 1.1)])
thinwall([p15, p16]; parts=[door(0.15, 0.62, lr)])
thinwall([p16, p31]; parts=[window(1.45, 1.1)])
thinwall([p17, p18])
thinwall([p17, p21])
thinwall([p18, p19])
thinwall([p18, p22])
thinwall([p19, p20])
thickwall([p20, p27])
thinwall([p21, p22])
thinwall([p21, p25])
thinwall([p23, p24])
thinwall([p23, p37]; parts=[window(0.74, 1.35)])
thinwall([p24, p25])
thinwall([p24, p38])
thickwall([p26, p27])
thinwall([p26, p33])
thinwall([p28, p29])
thinwall([p28, p35])
thinwall([p29, p45])
thickwall([p30, p31]; parts=[window(0.41, 0.95)])
thickwall([p30, p53]; parts=[door(1.49, 0.75, lf), window(2.94, 0.67), window(3.89, 2.25)])
thinwall([p32, p33])
thinwall([p33, p34])
thinwall([p34, p41])
thinwall([p35, p36])
thinwall([p35, p43])
thinwall([p36, p44])
thinwall([p37, p38]; parts=[door(1.4, 0.75, lf)])
thickwall([p37, p49]; parts=[door(0.55, 0.85, lr)])
thinwall([p38, p39])
thinwall([p40, p41])
thinwall([p40, p56])
thinwall([p42, p43])
thinwall([p43, p44])
thinwall([p43, p47])
thinwall([p44, p45])
thinwall([p46, p47])
thinwall([p47, p48])
thickwall([p47, p51])
thinwall([p48, p52])
thinwall([p49, p50])
thinwall([p49, p68]; parts=[window(0.86, 4.8)])
thinwall([p50, p58])
thinwall([p51, p52])
thickwall([p51, p61])
thinwall([p52, p53]; parts=[door(0.8, 0.62, rf)])
thickwall([p53, p54]; parts=[window(0.4, 0.67)])
thinwall([p53, p62])
thinwall([p54, p64])
thickwall([p55, p56])
thinwall([p56, p57]; parts=[window(3.0, 0.8)])
thinwall([p57, p59])
thickwall([p58, p60])
thickwall([p59, p71]; parts=[window(1.75, 1.35)])
thinwall([p61, p62])
thinwall([p61, p74])
thickwall([p62, p63])
thickwall([p63, p64])
thinwall([p63, p75])
thinwall([p65, p66])
thinwall([p65, p73])
thinwall([p66, p78])
thinwall([p67, p68])
thinwall([p68, p69])
thickwall([p68, p79])
thinwall([p69, p70])
thinwall([p70, p71])
thickwall([p71, p80]; parts=[door(0.85, 0.85), window(2.4, 2.85)])
thickwall([p72, p73])
thinwall([p72, p76]; parts=[door(0.41, 2.5)])
thinwall([p73, p77])
thinwall([p74, p75])
thickwall([p76, p77])
thickwall([p77, p78])
thickwall([p79, p80]; parts=[window(2.4, 1.7)])


##

closet(xy(6.38, 20.02), xy(5.98, 19.85))
closet(xy(3.55, 20.7), xy(3.0, 17.05))
closet(xy(14.8, 20.6), xy(12.0, 21.2))
closet(xy(6.35, 21.25), xy(5.65, 22.95))
closet(xy(5.55, 25.0), xy(4.85, 25.2))
closet(xy(6.35, 24.8), xy(5.7, 25.25))
closet(xy(11.3, 39.85), xy(10.8, 40.4))
toilet(xy(9.57, 21.7), 270)
toilet(xy(5.88, 26.42), 90)
sink(xy(7.0, 25.87), 270)

##

show_auxiliary_labels(labels_only=false)
