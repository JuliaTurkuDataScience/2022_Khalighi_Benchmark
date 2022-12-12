p7 = scatter(random_params_benchmark.ExecutionTime,
    random_params_benchmark.Error, scale=:log,
    group=random_params_benchmark.Label,
    shape=random_params_benchmark.Shape,
    markersize=3, markerstrokewidth=0,
    colour = random_params_benchmark.Colour,
    title="(a)", titleloc=:left, titlefont=font(10),
    xlabel=time_label, ylabel=error_label,
    legendposition=:bottomleft, legendtitle="Method")

p8 = @df random_params_benchmark boxplot(:Label, :Error,
    yscale=:log, ylabel=error_label,
    group=random_params_benchmark.Label,
    colour=random_params_benchmark.Colour,
    fillcolor=random_params_benchmark.Colour,
    title="(b)", titleloc=:left, titlefont=font(10),
    legend=false, markerstrokewidth=0)

p9 = @df random_params_benchmark boxplot(:Label, :ExecutionTime,
    yscale=:log, ylabel=time_label,
    group=random_params_benchmark.Label,
    colour=random_params_benchmark.Colour,
    fillcolor=random_params_benchmark.Colour,
    title="(c)", titleloc=:left, titlefont=font(10),
    legend=false, markerstrokewidth=0)

l3 = @layout [b{0.5w} grid(2, 1)]
PltRnd = plot(p7, p8, p9,
    layout=l3,
    size=(800, 500))
savefig(PltRnd, joinpath(output_dir, "PltRnd.png"))
savefig(PltRnd, joinpath(output_dir, "PltRnd.svg"))