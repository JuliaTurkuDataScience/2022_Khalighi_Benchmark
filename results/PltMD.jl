p4 = plot(sir_benchmark.ExecutionTime,
    sir_benchmark.Error, scale=:log,
    group=sir_benchmark.Label,
    shape=sir_benchmark.Shape, markersize=3,
    colour=sir_benchmark.Colour,
    title="(a)", titleloc=:left, titlefont=font(10),
    xlabel=time_label, ylabel=error_label,
    legend=false, thickness_scaling=1,
    legendposition=:outerright, legendfontsize=6,
    legendtitle="Method", legendtitlefontsize=7)

p5 = plot(lotka_volterra_benchmark.ExecutionTime,
    lotka_volterra_benchmark.Error, scale=:log,
    group=lotka_volterra_benchmark.Label,
    shape=lotka_volterra_benchmark.Shape, markersize=3,
    colour=lotka_volterra_benchmark.Colour,
    title="(b)", titleloc=:left, titlefont=font(10),
    xlabel=time_label, ylabel=error_label,
    legend=false, thickness_scaling=1)

p6 = plot(DynLV[:, 1], Matrix(DynLV[:, 2:4]), xlabel="Time", ylabel="Abundance of species",
    thickness_scaling=1, framestyle=:box, labels=["X1" "X2" "X3"],
    title="(c)", titleloc=:left, titlefont=font(10))

l2 = @layout [b{0.6h}; grid(1, 2)]
PltMD = plot(p4, p5, p6,
    layout=l2,
    size=(800, 600))
savefig(PltMD, joinpath(output_dir, "PltMD.svg"))
savefig(PltMD, joinpath(output_dir, "PltMD.png"))