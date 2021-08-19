#!/usr/bin/env gnuplot
# Version >= 5.2

lambdaminus = 1 # bzw. 0

if (lambdaminus) {
    set term epslatex color size 7in, 4.5in
	set output "tv4-l-minus.tex"
	# set term epscairo color size 7in, 4.5in
	# set output "tv4-l-minus.eps"

	set title "Verlauf der Radien mit Ringenindizes ($\\lambda_-$)"
} else {
    set term epslatex color size 7in, 4.5in
	set output "tv4-l-plus.tex"
	# set term epscairo color size 7in, 4.5in
	# set output "tv4-l-plus.eps"

	set title "Verlauf der Radien mit Ringenindizes ($\\lambda_+$)"
}

set decimalsign ","

set ylabel "Radien$^2$ $r_m^2/\\si{\\micro\\meter\\squared}$"
set xlabel "Ringindex $p$ (Einheitlos)"

set mxtics
set mytics
set samples 10000

f(x) = m*x + c # Linear fit

array A_m[5]
array A_m_err[5]
array A_c[5]
array A_c_err[5]
array chisq[5]
array titel[5]
array input_mp[5]
array titel_mp[5]
array A_p0[5]
array A_p0_err[5]

# http://gnuplot.info/demo_5.4/array.1.gnu
array strom[5]     = ["2.495", "4.190", "5.662", "7.01", "8.78"]
array strom_err[5] = ["5", "10", "10", "1", "1"]

# https://stackoverflow.com/a/17884635
do for [t=1:5] {
	inp = "tv4-".t.".dat"
	input_mp[t] = inp
	titel_mp[t] = "$I = \\SI{".strom[t]."(".strom_err[t].")}{\\ampere}$"

	m = 1; c = 1;
	if (lambdaminus) {
		fit f(x) inp u 1:($2*$2):(2*$2*$3) yerrors via m,c
	} else {
		fit f(x) inp u 1:($4*$4):(2*$4*$5) yerrors via m,c
	}
	
	A_m[t] = m
	A_m_err[t] = m_err
	A_c[t] = c
	A_c_err[t] = c_err
	chisq[t] = FIT_STDFIT**2
	titel[t] = "$".gprintf("%.5f", m)."p + (".gprintf("%.5f", c).")$"

	A_p0[t] = -c/m
	A_p0_err[t] = abs(A_p0[t]) * sqrt((c_err/c)**2 + (m_err/m)**2)
}

set key bottom right vertical maxrows 5 width -7


if (lambdaminus) {
	plot for [i=1:5] input_mp[i] u 1:($2*$2):(2*$2*$3) with yerrorbars title titel_mp[i] pointtype 77 lc i, for [i=1:5] A_m[i]*x+A_c[i] title titel[i] lc i
} else {
	plot for [i=1:5] input_mp[i] u 1:($4*$4):(2*$4*$5) with yerrorbars title titel_mp[i] pointtype 77 lc i, for [i=1:5] A_m[i]*x+A_c[i] title titel[i] lc i
}

print ""
if (lambdaminus) { print "lambda-" } else { print "lambda+" }

# Raw data output
print A_m
print A_m_err

# LaTeX table output
print "\\toprule"
print "Strom $I/\\si{\\ampere}$ & $m/\\si{\\micro\\meter\\squared}$ & $c/\\si{\\micro\\meter\\squared}$ & $p_0$ & $\\chi^2_\\text{red}$ \\\\"
print "\\midrule"
do for [t=1:5] {
	print "\t\\num{".strom[t]."(".strom_err[t].")} & \\num{".gprintf("%.5f", A_m[t])."(".gprintf("%.0f", A_m_err[t]*10**5).")} & \\num{".gprintf("%.5f", A_c[t])."(".gprintf("%.0f", A_c_err[t]*10**5).")}"." & \\num{".gprintf("%.5f", A_p0[t])."(".gprintf("%.0f", A_p0_err[t]*10**5).")} & \\num{".gprintf("%.5f", chisq[t])."} \\\\"
}
print "\\bottomrule"
print ""

# Raw data output in table form
print "# Nr\tm/um^2 \tm_err/um^2\tc/um^2 \t c_err/um^2 \t p \t p_err"
do for [t=1:5] {
	print "".t."\t".sprintf("%.10f", A_m[t])."\t".sprintf("%.10f", A_m_err[t])."\t".sprintf("%.10f", A_c[t])."\t".sprintf("%.10f", A_c_err[t])."\t".sprintf("%.10f", A_p0[t])."\t".sprintf("%.10f", A_p0_err[t])
}