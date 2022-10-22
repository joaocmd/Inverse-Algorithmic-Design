import Pkg
Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))
Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))
##

include("OutAux.jl")

thinwall(wallpath; parts=[]) = wall(wallpath, 0.11; parts=parts)
thickwall(wallpath; parts=[]) = wall(wallpath, 0.25; parts=parts)

x1 = 0.96
x2 = 4.38
x3 = 5.78
x4 = 7.69
x5 = 9.68
x6 = 12.91
x7 = 19.2
x8 = 20.78
x9 = 21.87
x10 = 22.32
x11 = 23.59
x12 = 24.11
x13 = 25.7
x14 = 26.78
x15 = 28.28
x16 = 29.02
x17 = 30.49
x18 = 31.34
x19 = 32.43
x20 = 33.6
x21 = 35.92
x22 = 38.18
x23 = 40.28
x24 = 41.07
x25 = 42.68
x26 = 44.15

y1 = 0.49
y2 = 3.11
y3 = 3.71
y4 = 4.28
y5 = 4.88
y6 = 5.4
y7 = 5.78
y8 = 6.99
y9 = 7.55
y10 = 8.57
y11 = 8.89
y12 = 9.37
y13 = 9.95
y14 = 10.43
y15 = 10.88
y16 = 11.75
y17 = 12.57
y18 = 13.52
y19 = 14.45
y20 = 17.62

p1 = xy(x1, y1)
p2 = xy(x1, y5)
p3 = xy(x1, y14)
p4 = xy(x1, y18)
p5 = xy(x1, y20)
p6 = xy(x2, y1)
p7 = xy(x2, y3)
p8 = xy(x2, y4)
p9 = xy(x2, y5)
p10 = xy(x2, y6)
p11 = xy(x2, y11)
p12 = xy(x2, y12)
p13 = xy(x2, y13)
p14 = xy(x2, y14)
p15 = xy(x2, y16)
p16 = xy(x2, y18)
p17 = xy(x2, y19)
p18 = xy(x2, y20)
p19 = xy(x3, y3)
p20 = xy(x3, y5)
p21 = xy(x3, y6)
p22 = xy(x3, y11)
p23 = xy(x3, y12)
p24 = xy(x3, y14)
p25 = xy(x3, y17)
p26 = xy(x3, y18)
p27 = xy(x3, y19)
p28 = xy(x4, y17)
p29 = xy(x4, y18)
p30 = xy(x5, y1)
p31 = xy(x5, y3)
p32 = xy(x5, y12)
p33 = xy(x5, y14)
p34 = xy(x5, y18)
p35 = xy(x5, y19)
p36 = xy(x5, y20)
p37 = xy(x6, y19)
p38 = xy(x6, y20)
p39 = xy(x7, y19)
p40 = xy(x7, y20)
p41 = xy(x8, y19)
p42 = xy(x8, y20)
p43 = xy(x9, y2)
p44 = xy(x9, y14)
p45 = xy(x10, y6)
p46 = xy(x10, y8)
p47 = xy(x10, y14)
p48 = xy(x10, y18)
p49 = xy(x10, y19)
p50 = xy(x10, y20)
p51 = xy(x11, y2)
p52 = xy(x11, y4)
p53 = xy(x11, y5)
p54 = xy(x11, y6)
p55 = xy(x11, y7)
p56 = xy(x12, y17)
p57 = xy(x13, y8)
p58 = xy(x13, y12)
p59 = xy(x13, y14)
p60 = xy(x13, y17)
p61 = xy(x13, y18)
p62 = xy(x14, y8)
p63 = xy(x14, y12)
p64 = xy(x15, y8)
p65 = xy(x15, y9)
p66 = xy(x15, y10)
p67 = xy(x15, y12)
p68 = xy(x16, y8)
p69 = xy(x16, y9)
p70 = xy(x16, y10)
p71 = xy(x16, y12)
p72 = xy(x16, y15)
p73 = xy(x16, y18)
p74 = xy(x17, y18)
p75 = xy(x17, y19)
p76 = xy(x17, y20)
p77 = xy(x18, y7)
p78 = xy(x18, y8)
p79 = xy(x19, y7)
p80 = xy(x20, y8)
p81 = xy(x21, y7)
p82 = xy(x21, y8)
p83 = xy(x22, y7)
p84 = xy(x22, y8)
p85 = xy(x23, y7)
p86 = xy(x23, y8)
p87 = xy(x23, y10)
p88 = xy(x24, y8)
p89 = xy(x25, y2)
p90 = xy(x25, y3)
p91 = xy(x25, y7)
p92 = xy(x25, y8)
p93 = xy(x25, y10)
p94 = xy(x25, y15)
p95 = xy(x26, y3)
p96 = xy(x26, y8)

##

delete_all_shapes()

thickwall([p1, p2]; parts=[window(0.38, 0.6), window(1.31, 0.71), window(2.37, 0.71), window(3.49, 0.6)])
thickwall([p1, p6])
thickwall([p2, p3]; parts=[window(0.19, 0.65), window(1.28, 0.6), window(2.43, 0.6), window(3.46, 0.71), window(4.66, 0.6)])
thinwall([p2, p9])
thickwall([p3, p4]; parts=[window(0.23, 0.5), window(1.21, 0.71), window(2.39, 0.65)])
thinwall([p3, p14])
thickwall([p4, p5]; parts=[window(0.39, 0.65), window(1.48, 0.82), window(2.71, 0.82)])
thinwall([p4, p16])
thickwall([p5, p18])
thinwall([p6, p7])
thickwall([p6, p30]; parts=[window(0.06, 0.6), window(1.1, 0.6), window(2.25, 0.33), window(3.29, 0.6), window(4.4, 0.5)])
thinwall([p7, p8])
thinwall([p7, p19])
thinwall([p8, p9])
thinwall([p9, p10])
thickwall([p11, p12])
thickwall([p12, p13])
thickwall([p13, p14])
thickwall([p14, p15])
thickwall([p15, p16])
thickwall([p17, p18])
thickwall([p17, p27])
thickwall([p18, p36]; parts=[window(0.26, 0.82), window(1.35, 0.82), window(2.41, 0.71), window(3.42, 0.65), window(4.49, 0.6)])
thinwall([p19, p20])
thinwall([p19, p31])
thinwall([p20, p21])
thinwall([p22, p23])
thinwall([p23, p24])
thickwall([p23, p32])
thinwall([p24, p33])
thinwall([p25, p28])
thinwall([p26, p29])
thinwall([p27, p35])
thinwall([p29, p34])
thickwall([p30, p31])
thickwall([p31, p32]; parts=[window(0.35, 0.5), window(1.36, 0.65), window(2.53, 0.6), window(3.59, 0.65), window(4.71, 0.6)])
thickwall([p32, p33])
thickwall([p33, p34])
thickwall([p36, p38]; parts=[window(0.25, 0.65), window(1.28, 0.71), window(2.37, 0.6)])
thickwall([p38, p40]; parts=[window(0.23, 0.5), window(1.21, 0.71), window(2.28, 0.6), window(3.34, 0.65), window(4.35, 0.65), window(5.41, 0.65)])
thinwall([p39, p40])
thickwall([p40, p42]; parts=[window(0.16, 0.71)])
thinwall([p41, p42])
thickwall([p42, p50]; parts=[window(0.65, 0.71)])
thinwall([p43, p44])
thickwall([p43, p51])
thickwall([p44, p47])
thinwall([p45, p54])
thinwall([p46, p57])
thickwall([p47, p59])
thinwall([p48, p61])
thinwall([p49, p50])
thickwall([p50, p76]; parts=[window(0.23, 0.6), window(1.24, 0.6), window(2.28, 0.6), window(4.27, 0.65), window(5.31, 0.65), window(6.26, 0.65), window(7.22, 0.65)])
thickwall([p51, p52])
thinwall([p52, p53])
thickwall([p53, p54])
thickwall([p54, p55])
thinwall([p57, p58])
thinwall([p57, p62])
thickwall([p58, p59]; parts=[door(0.34, 0.46)])
thinwall([p58, p63])
thinwall([p62, p63])
thinwall([p62, p92])
thinwall([p63, p67]; parts=[door(0.35, 0.35)])
thinwall([p64, p65])
thinwall([p64, p78])
thinwall([p65, p66])
thinwall([p65, p69])
thinwall([p66, p67])
thinwall([p66, p70])
thickwall([p67, p71])
thickwall([p68, p69])
thickwall([p69, p70]; parts=[door(0.28, 0.46)])
thickwall([p70, p71])
thickwall([p71, p72]; parts=[door(0.31, 0.35)])
thickwall([p72, p73])
thickwall([p72, p94])
thickwall([p73, p74])
thickwall([p74, p75])
thickwall([p75, p76])
thinwall([p77, p78])
thinwall([p77, p79])
thinwall([p80, p82])
thickwall([p81, p82])
thinwall([p81, p83])
thinwall([p82, p84])
thinwall([p83, p85])
thickwall([p84, p86])
thinwall([p85, p91])
thinwall([p86, p87])
thickwall([p86, p88])
thinwall([p87, p93])
thickwall([p88, p96])
thickwall([p89, p90])
thickwall([p90, p91])
thickwall([p90, p95])
thickwall([p91, p92]; parts=[door(0.39, 0.35)])
thickwall([p92, p93]; parts=[window(0.43, 0.65)])
thickwall([p93, p94])
thickwall([p95, p96])

railing([p37, p38], 0.07)
railing([p56, p60], 0.07)

show_auxiliary_labels(labels_only=false)

##

closet(xy(28.83, 9.08), xy(28.69, 9.22))
closet(xy(28.85, 9.0), xy(28.45, 9.22))

