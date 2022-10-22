import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.3; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.67; parts=parts)

x1 = 2.17
x2 = 9.39
x3 = 9.97
x4 = 12.87
x5 = 13.28
x6 = 17.17
x7 = 21.63
x8 = 28.84
x9 = 42.89
x10 = 46.44
x11 = 48.87
x12 = 49.87
x13 = 52.71
x14 = 53.84
x15 = 57.32
x16 = 57.64
x17 = 59.82
x18 = 63.17
x19 = 64.82
x20 = 68.13
x21 = 70.01
x22 = 72.41
x23 = 75.03
x24 = 80.22
x25 = 85.29
x26 = 89.95
x27 = 91.72
x28 = 95.32
x29 = 98.6

y1 = 1.09
y2 = 6.93
y3 = 7.92
y4 = 8.47
y5 = 9.35
y6 = 9.74
y7 = 10.86
y8 = 11.99
y9 = 12.83
y10 = 13.46
y11 = 15.38
y12 = 15.65
y13 = 16.87
y14 = 18.84
y15 = 19.34
y16 = 19.85
y17 = 20.89
y18 = 22.23
y19 = 23.28
y20 = 24.29
y21 = 26.25
y22 = 28.05
y23 = 29.98
y24 = 30.62
y25 = 32.22
y26 = 39.33

p1 = xy(x1, y1)
p2 = xy(x1, y7)
p3 = xy(x1, y19)
p4 = xy(x1, y24)
p5 = xy(x1, y26)
p6 = xy(x2, y1)
p7 = xy(x2, y4)
p8 = xy(x2, y5)
p9 = xy(x3, y7)
p10 = xy(x3, y8)
p11 = xy(x3, y16)
p12 = xy(x3, y17)
p13 = xy(x3, y18)
p14 = xy(x3, y19)
p15 = xy(x3, y21)
p16 = xy(x3, y24)
p17 = xy(x3, y25)
p18 = xy(x3, y26)
p19 = xy(x4, y4)
p20 = xy(x4, y7)
p21 = xy(x4, y8)
p22 = xy(x4, y16)
p23 = xy(x4, y17)
p24 = xy(x4, y19)
p25 = xy(x4, y22)
p26 = xy(x4, y23)
p27 = xy(x4, y25)
p28 = xy(x5, y4)
p29 = xy(x5, y5)
p30 = xy(x6, y22)
p31 = xy(x6, y23)
p32 = xy(x7, y1)
p33 = xy(x7, y4)
p34 = xy(x7, y17)
p35 = xy(x7, y19)
p36 = xy(x7, y23)
p37 = xy(x7, y25)
p38 = xy(x7, y26)
p39 = xy(x8, y25)
p40 = xy(x8, y26)
p41 = xy(x9, y25)
p42 = xy(x9, y26)
p43 = xy(x10, y25)
p44 = xy(x10, y26)
p45 = xy(x11, y2)
p46 = xy(x11, y19)
p47 = xy(x12, y8)
p48 = xy(x12, y12)
p49 = xy(x12, y19)
p50 = xy(x12, y23)
p51 = xy(x12, y25)
p52 = xy(x12, y26)
p53 = xy(x13, y2)
p54 = xy(x13, y6)
p55 = xy(x13, y7)
p56 = xy(x13, y8)
p57 = xy(x13, y10)
p58 = xy(x14, y22)
p59 = xy(x15, y12)
p60 = xy(x15, y17)
p61 = xy(x15, y19)
p62 = xy(x16, y22)
p63 = xy(x16, y23)
p64 = xy(x17, y11)
p65 = xy(x17, y12)
p66 = xy(x17, y17)
p67 = xy(x18, y12)
p68 = xy(x18, y13)
p69 = xy(x18, y15)
p70 = xy(x18, y17)
p71 = xy(x19, y12)
p72 = xy(x19, y13)
p73 = xy(x19, y15)
p74 = xy(x19, y17)
p75 = xy(x19, y20)
p76 = xy(x19, y23)
p77 = xy(x20, y23)
p78 = xy(x20, y25)
p79 = xy(x20, y26)
p80 = xy(x21, y9)
p81 = xy(x21, y12)
p82 = xy(x22, y9)
p83 = xy(x23, y12)
p84 = xy(x24, y9)
p85 = xy(x24, y12)
p86 = xy(x25, y9)
p87 = xy(x25, y12)
p88 = xy(x26, y9)
p89 = xy(x26, y12)
p90 = xy(x26, y14)
p91 = xy(x27, y12)
p92 = xy(x28, y2)
p93 = xy(x28, y3)
p94 = xy(x28, y9)
p95 = xy(x28, y11)
p96 = xy(x28, y14)
p97 = xy(x28, y20)
p98 = xy(x29, y3)
p99 = xy(x29, y11)

##

delete_all_shapes()

thickwall([p1, p2]; parts=[window(0.87, 1.28), window(2.94, 1.58), window(5.31, 1.58), window(7.81, 1.34)])
thickwall([p1, p6])
thickwall([p2, p3]; parts=[window(0.47, 1.46), window(2.9, 1.34), window(5.46, 1.28), window(7.77, 1.58), window(10.45, 1.34)])
thinwall([p2, p9])
thickwall([p3, p4]; parts=[window(0.54, 1.16), window(2.73, 1.74), window(5.35, 1.46)])
thinwall([p3, p14])
thickwall([p4, p5]; parts=[window(0.45, 1.46), window(2.88, 1.83), window(5.62, 1.83)])
thinwall([p4, p16])
thickwall([p5, p18])
thinwall([p6, p7])
thickwall([p6, p32]; parts=[window(0.48, 1.34), window(2.85, 1.28), window(5.41, 0.73), window(7.72, 1.28), window(10.22, 0.97)])
thinwall([p7, p8])
thinwall([p7, p19])
thinwall([p8, p9])
thinwall([p9, p10])
thickwall([p11, p12])
thinwall([p12, p13])
thickwall([p13, p14])
thickwall([p14, p15])
thickwall([p15, p16])
thinwall([p17, p18])
thinwall([p17, p27])
thickwall([p18, p38]; parts=[window(0.39, 1.83), window(2.82, 1.74), window(5.19, 1.58), window(7.45, 1.46), window(9.82, 1.34)])
thinwall([p19, p28])
thinwall([p20, p21])
thinwall([p20, p29])
thinwall([p22, p23])
thinwall([p23, p24])
thinwall([p23, p34])
thinwall([p24, p35])
thinwall([p25, p30])
thinwall([p26, p31])
thinwall([p27, p37])
thinwall([p28, p29])
thinwall([p28, p33])
thinwall([p31, p36])
thickwall([p32, p33])
thickwall([p33, p34]; parts=[window(0.61, 1.16), window(2.86, 1.46), window(5.47, 1.28), window(7.85, 1.46), window(10.35, 1.34)])
thickwall([p34, p35])
thickwall([p35, p36])
thickwall([p38, p40]; parts=[window(0.54, 1.46), window(2.85, 1.58), window(5.29, 1.34)])
thickwall([p40, p42]; parts=[window(0.52, 1.16), window(2.71, 1.58), window(5.09, 1.34), window(7.46, 1.46), window(9.71, 1.46), window(12.09, 1.46)])
thinwall([p41, p42])
thickwall([p42, p44]; parts=[window(0.35, 1.58)])
thinwall([p43, p44])
thickwall([p44, p52]; parts=[window(1.43, 1.58)])
thinwall([p45, p46])
thinwall([p45, p53])
thinwall([p46, p49])
thinwall([p47, p56])
thinwall([p48, p59])
thinwall([p49, p61])
thinwall([p50, p63])
thinwall([p51, p52])
thickwall([p52, p79]; parts=[window(0.49, 1.34), window(2.75, 1.34), window(5.06, 1.34), window(9.51, 1.46), window(11.82, 1.46), window(13.95, 1.46), window(16.08, 1.46)])
thinwall([p53, p54])
thinwall([p54, p55])
thinwall([p55, p56])
thinwall([p56, p57])
thinwall([p59, p60])
thinwall([p59, p64])
thinwall([p60, p61]; parts=[door(0.79, 0.98)])
thinwall([p60, p66])
thinwall([p64, p65])
thinwall([p65, p66])
thinwall([p66, p70]; parts=[door(0.77, 0.79)])
thinwall([p67, p68])
thinwall([p68, p69])
thinwall([p68, p72])
thinwall([p69, p70])
thinwall([p69, p73])
thinwall([p70, p74])
thinwall([p71, p72])
thinwall([p71, p81])
thinwall([p72, p73]; parts=[door(0.62, 1.1)])
thinwall([p73, p74])
thickwall([p74, p75]; parts=[door(0.73, 0.79)])
thinwall([p75, p76])
thinwall([p75, p97])
thickwall([p76, p77])
thickwall([p77, p78])
thickwall([p78, p79])
thinwall([p80, p81])
thinwall([p80, p82])
thinwall([p83, p85])
thinwall([p84, p85])
thinwall([p84, p86])
thinwall([p85, p87])
thinwall([p86, p88])
thinwall([p87, p89])
thinwall([p88, p94])
thinwall([p89, p90])
thickwall([p89, p91])
thinwall([p90, p96])
thinwall([p91, p95])
thinwall([p92, p93])
thinwall([p93, p94])
thickwall([p93, p98])
thinwall([p94, p95]; parts=[door(0.93, 0.79)])
thickwall([p95, p96]; parts=[window(1.19, 1.46)])
thickwall([p95, p99])
thickwall([p96, p97])
thickwall([p98, p99])

railing([p39, p40], 0.12)
railing([p58, p62], 0.12)

show_auxiliary_labels(labels_only=true, text_size=0.6)
##

closet(xy(64.37, 20.28), xy(64.07, 20.58))
closet(xy(64.43, 20.1), xy(63.52, 20.58))

##
