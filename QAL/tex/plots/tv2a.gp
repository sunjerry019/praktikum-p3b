#!/usr/bin/env gnuplot
# Ver > 5.0

set term epslatex color size 6in, 5in
set output "tv2a.tex"
set decimalsign locale 'de_DE.UTF-8'

set title "Zuordnung der Legendrepolynome im akustischen sphärischen Oszillator"
set ylabel "Amplitude $A$ ($\\si{\\volt}$)"
set xlabel "$\\cos(\\theta/\\si{\\degree})$"

set mxtics
set mytics
set samples 10000

# Linien
set key bottom right spacing 1 vertical maxrows 3

# (x, y, xdelta, ydelta)

# l = 2
A =  1.5 
B = -0.5
two(x) = A*(x**2) + B
fit two(x) "tv2a.dat" u (cos($2*pi/180)):3:((abs(sin($1*pi/180))*(pi/180))/2):(0.002) xyerrors via A,B

# l = 3
C =  2.5
D = -1.5
thr(x) = C*(x**3) + D*x
fit thr(x) "tv2a.dat" u (cos($2*pi/180)):(-$4):((abs(sin($1*pi/180))*(pi/180))/2):(0.002) xyerrors via C,D

# l = 4
E =  35/8
F = -30/8
G =  3 /8
fou(x) = E*(x**4) + F*(x**2) + G
fit fou(x) "tv2a.dat" u (cos($2*pi/180)):(-$5):((abs(sin($1*pi/180))*(pi/180))/2):(0.002) xyerrors via E,F,G

set xrange [-1:0]

zero(x) = 0

plot two(x) title "$l = 2$" lc 1, \
     thr(x) title "$l = 3$" lc 2, \
     fou(x) title "$l = 4$" lc 3, \
	 "tv2a.dat" u (cos($2*pi/180)):3:((abs(sin($1*pi/180))*(pi/180))/2):(0.002) with xyerrorbars title "$f = \\SI{3.663}{\\hertz}" pointtype 1 lc 1, \
	 "tv2a.dat" u (cos($2*pi/180)):(-$4):((abs(sin($1*pi/180))*(pi/180))/2):(0.002) with xyerrorbars title "$f = \\SI{4.950}{\\hertz}" pointtype 1 lc 2, \
	 "tv2a.dat" u (cos($2*pi/180)):(-$5):((abs(sin($1*pi/180))*(pi/180))/2):(0.002) with xyerrorbars title "$f = \\SI{6.190}{\\hertz}" pointtype 1 lc 3, \
	 zero(x) notitle lc 0 dashtype 2