#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv1-1.tex"
set decimalsign locale 'de_DE.UTF-8'

set title "Eigenfrequenz $f$ gegen Peak-Nummer $n$"
set ylabel "Eigenfrequenz $f$ ($\\si{\\hertz}$)"
set xlabel "Peak-Nummer $n$ (Einheitlos)"

set mxtics
set mytics
set samples 10000

f(x) = m*x + c

# (x, y, xdelta, ydelta)
fit f(x) "tv1.dat" u 1:2 via m,c

set xrange [0:9]

# Linien
set key bottom right spacing 2

titel = "$(".gprintf("%.5f", m).")n + (".gprintf("%.5f", c).")$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv1.dat" u 1:2 title "Messpunkte" pointtype 1 lc rgb 'dark-goldenrod'
