#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv1.tex"
# set term epscairo color size 6in, 4in
# set output "tv1.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Magnetfeldstärke $B$ gegen Strom $I$"
set ylabel "Magnetfeldstärke $B$ ($\\si{\\milli\\tesla}$)"
set xlabel "Strom $I$ ($\\si{\\ampere}$)"

set mxtics
set mytics
set samples 10000

f(x) = m*x + c

# (x, y, xdelta, ydelta)
fit f(x) "tv1.dat" u 1:2:3:4 xyerrors via m,c

set xrange [0:10]

# Linien
set key bottom right spacing 2

titel = "$(".gprintf("%.5f", m).")I + (".gprintf("%.5f", c).")$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv1.dat" u 1:2:3:4 with xyerrorbars title "Messpunkte" pointtype 0 lc rgb 'dark-goldenrod'
