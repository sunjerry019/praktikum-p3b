#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv4-B-K.tex"
# set term epscairo color size 6in, 4in
# set output "tv1.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Wellenzahlunterschied $K/2$ gegen Magnetfeldstärke $B$"
set ylabel "Wellenzahlunterschied $K/2$ ($\\si{\\per\\meter}$)"
set xlabel "Magnetfeldstärke $B$ ($\\si{\\tesla}$)"

set mxtics
set mytics
set samples 10000

f(x) = m*x + c

# (x, y, xdelta, ydelta)
fit f(x) "tv4-B-K.dat" u 1:($3/2):2:($4/2) xyerrors via m,c

# Linien
set key bottom right spacing 2

titel = "$(".gprintf("%.5f", m).")B + (".gprintf("%.5f", c).")$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv4-B-K.dat" u 1:($3/2):2:($4/2) with xyerrorbars title "Messpunkte" pointtype 0 lc rgb 'dark-goldenrod'
