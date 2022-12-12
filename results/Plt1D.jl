p1 = plot(nonstiff_benchmark.ExecutionTime,
    nonstiff_benchmark.Error, scale=:log,
    group=nonstiff_benchmark.Label,
    shape=nonstiff_benchmark.Shape, markersize=3,
    colour=nonstiff_benchmark.Colour,
    title="(a)", titleloc=:left, titlefont=font(10),
    xlabel=time_label, ylabel=error_label,
    legend=false, thickness_scaling=1)

p2 = plot(stiff_benchmark.ExecutionTime,
    stiff_benchmark.Error, scale=:log,
    group=stiff_benchmark.Label,
    shape=stiff_benchmark.Shape, markersize=3,
    colour=stiff_benchmark.Colour,
    title="(b)", titleloc=:left, titlefont=font(10),
    xlabel=time_label, ylabel=error_label,
    legend=false, thickness_scaling=1,
    legendposition=:outerbottom, legendfontsize=6,
    legendtitle="Method", legendtitlefontsize=7)

p3 = plot(harmonic_benchmark.ExecutionTime,
    harmonic_benchmark.Error, scale=:log,
    group=harmonic_benchmark.Label,
    shape=harmonic_benchmark.Shape, markersize=3,
    colour=harmonic_benchmark.Colour,
    title="(a)", titleloc=:left, titlefont=font(10),
    xlabel=time_label, ylabel=error_label,
    legend=false, thickness_scaling=1)

l1 = @layout [[grid(2, 1)] b{0.5w}]
Plt1D = plot(p1, p3, p2,
    layout=l1,
    size=(800, 600))
savefig(Plt1D, joinpath(output_dir, "Plt1D.svg"))
savefig(Plt1D, joinpath(output_dir, "Plt1D.png"))