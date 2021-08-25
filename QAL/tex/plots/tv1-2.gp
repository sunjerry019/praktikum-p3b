#!/usr/bin/env gnuplot

set term epslatex color size 5in, 3in
set output "tv1-2.tex"
set decimalsign locale 'de_DE.UTF-8'

set title "Lebensdauer $\\nicefrac{1}{\\Delta f}$ gegen Peak-Nummer $n$"
set ylabel "Lebensdauer $\\nicefrac{1}{\\Delta f}$ ($\\si{\\second}$)"
set xlabel "Peak-Nummer $n$ (Einheitlos)"

set mxtics
set mytics

set xrange [0:9]

# Linien
set key top right spacing 1

f(x) = A*(x**2) + B*x + C

# (x, y, xdelta, ydelta)
fit f(x) "tv1.dat" u 1:(1/$4) via A,B,C

set xrange [0:9]

titel = "$(".gprintf("%.7f", A).")n^2 + (".gprintf("%.7f", B).")n + (".gprintf("%.7f", C).")$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv1.dat" u 1:(1/$4) title "Messpunkte" pointtype 1 lc rgb 'dark-goldenrod'
