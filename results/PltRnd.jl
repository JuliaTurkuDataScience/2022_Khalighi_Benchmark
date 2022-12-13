
# Scatter plot of errors versus time of execution for several solutions of
# 1D and MD examples with random parameters and conditions
p7 = scatter(random_params_benchmark.ExecutionTime,
    random_params_benchmark.Error, scale=:log,
    group=random_params_benchmark.Label,
    shape=random_params_benchmark.Shape,
    markersize=3, markerstrokewidth=0,
    colour=random_params_benchmark.Colour,
    title="(a)", titleloc=:left, titlefont=font(10),
    xlabel=time_label, ylabel=error_label,
    legendposition=:bottomleft, legendtitle="Method")

# make linear fits by solver method and add them to the scatter plot
fits = Dict()

for method in sort(unique(random_params_benchmark.Method))

    method_subset = filter(:Method => x -> x == method, random_params_benchmark)
    fits[method] = fitlinear(log.(method_subset.ExecutionTime), log.(method_subset.Error))
    p7 = plot!(exp.(fits[method].x), exp.(fits[method].y),
        colour=aesthetics[method][3],
        linewidth=2, label=false)

    display(p7)

end

# boxplot of log error by solver method with data from the scatter plot above
p8 = @df random_params_benchmark boxplot(:Label, :Error,
    yscale=:log, ylabel=error_label,
    group=random_params_benchmark.Label,
    colour=random_params_benchmark.Colour,
    fillcolor=random_params_benchmark.Colour,
    title="(b)", titleloc=:left, titlefont=font(10),
    legend=false, markerstrokewidth=0)

# boxplot of log execution time by solver method with data from the scatter plot above
p9 = @df random_params_benchmark boxplot(:Label, :ExecutionTime,
    yscale=:log, ylabel=time_label,
    group=random_params_benchmark.Label,
    colour=random_params_benchmark.Colour,
    fillcolor=random_params_benchmark.Colour,
    title="(c)", titleloc=:left, titlefont=font(10),
    legend=false, markerstrokewidth=0)

# define plot layout
l3 = @layout [b{0.5w} grid(2, 1)]

# make multipanel plot
PltRnd = plot(p7, p8, p9,
    layout=l3,
    size=(800, 500))

# save plot as svg and png files in the "figures" directory
savefig(PltRnd, joinpath(output_dir, "PltRnd.png"))
savefig(PltRnd, joinpath(output_dir, "PltRnd.svg"))