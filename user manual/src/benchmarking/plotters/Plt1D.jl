# Errors versus time of execution of FdeSolver and Matlab codes
# for solving the one-dimensional differential equation

# Non-stiff example
p1 = plot(nonstiff_benchmark.ExecutionTime,
    nonstiff_benchmark.Error, scale=:log,
    group=nonstiff_benchmark.Label,
    shape=nonstiff_benchmark.Shape, markersize=3,
    colour=nonstiff_benchmark.Colour,
    title="(a) Non-stiff example", titleloc=:left,
    xlabel=time_label, ylabel=error_label,
    legend=false,markerstrokewidth=0.3,ms=3.5)

# Stiff example
p2 = plot(stiff_benchmark.ExecutionTime,
    stiff_benchmark.Error, scale=:log,
    group=stiff_benchmark.Label,
    shape=stiff_benchmark.Shape, markersize=3,
    colour=stiff_benchmark.Colour,
    title="(b) Stiff example", titleloc=:left,
    xlabel=time_label, ylabel=error_label,
    legend=false, markerstrokewidth=0.3,ms=3.5,
    legendposition=:outerbottom, legendfontsize=8,
    legendtitle="Method", legendtitlefontsize=10)

# High-order example
p3 = plot(harmonic_benchmark.ExecutionTime,
    harmonic_benchmark.Error, scale=:log,
    group=harmonic_benchmark.Label,
    shape=harmonic_benchmark.Shape, markersize=3,
    colour=harmonic_benchmark.Colour,
    title="(c) High-order example", titleloc=:left,
    xlabel=time_label, ylabel=error_label,
    legend=false,markerstrokewidth=0.3,ms=3.5)

# define plot layout
l1 = @layout [[grid(2, 1)] b{0.5w}]

# make multipanel plot
Plt1D = plot(p1, p3, p2,
    layout=l1,
    size=(800, 600))

# save plot as svg and png files in the "figures" directory
savefig(Plt1D, joinpath(output_dir, "Plt1D.svg"))
savefig(Plt1D, joinpath(output_dir, "Plt1D.png"))
