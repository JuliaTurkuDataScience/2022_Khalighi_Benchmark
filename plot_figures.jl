using Plots, CSV, DataFrames
using StatsPlots

nonstiff_benchmark = CSV.read("data/nonstiff_benchmark.csv", DataFrame, header=1)
stiff_benchmark = CSV.read("data/stiff_benchmark.csv", DataFrame, header=1)
harmonic_benchmark = CSV.read("data/harmonic_benchmark.csv", DataFrame, header=1)
lotka_volterra_benchmark = CSV.read("data/lotka_volterra_benchmark.csv", DataFrame, header=1)
sir_benchmark = CSV.read("data/sir_benchmark.csv", DataFrame, header=1)
random_params_benchmark = CSV.read("data/random_params_benchmark.csv", DataFrame, header=1)
DynLV = CSV.read("data/DynLV.csv", DataFrame, header=1)

### plot Examples

data_markers1 = [:circle, :square, :utriangle, :circle, :diamond, :square]
p1 = Nothing

for (plot_idx, method) in enumerate(unique(nonstiff_benchmark.Method))
    method_subset = filter(:Method => x -> x == method, nonstiff_benchmark)
    if plot_idx == 1
        p1 = plot(method_subset.ExecutionTime,
            method_subset.Error,
            scale=:log,
            label=method,
            markersize=3,
            shape=data_markers1[plot_idx],
            title="(a)",
            titleloc=:left,
            titlefont=font(10),
            xlabel="Execution time (sc, Log)",
            ylabel="Error: 2-norm (Log)",
            legend=false,
            colour = ifelse("Julia" in unique(method_subset.Language), :red, :blue))
    else
        plot!(method_subset.ExecutionTime,
            method_subset.Error,
            label=method,
            markersize=3,
            shape=data_markers1[plot_idx],
            colour = ifelse("Julia" in unique(method_subset.Language), :red, :blue))
    end
    display(p1)
end

filter!(:Error => x -> x < 10^5, stiff_benchmark)
p2 = Nothing

for (plot_idx, method) in enumerate(unique(stiff_benchmark.Method))
    method_subset = filter(:Method => x -> x == method, stiff_benchmark)
    if plot_idx == 1
        p2 = plot(method_subset.ExecutionTime,
            method_subset.Error,
            scale=:log,
            label=method,
            markersize=3,
            shape=data_markers1[plot_idx],
            title="(b)",
            titleloc=:left,
            titlefont=font(10),
            xlabel="Execution time (sc, Log)",
            ylabel="Error: 2-norm (Log)",
            legendposition=:outerbottom,
            legendfontsize=6,
            legendtitle="Solver Method",
            legendtitlefontsize=7,
            colour = ifelse("Julia" in unique(method_subset.Language), :red, :blue))
    else
        plot!(method_subset.ExecutionTime,
            method_subset.Error,
            label=method,
            markersize=3,
            shape=data_markers1[plot_idx],
            colour = ifelse("Julia" in unique(method_subset.Language), :red, :blue))
    end
    display(p2)
end

p3 = Nothing

for (plot_idx, method) in enumerate(unique(harmonic_benchmark.Method))
    method_subset = filter(:Method => x -> x == method, harmonic_benchmark)
    if plot_idx == 1
        p3 = plot(method_subset.ExecutionTime,
            method_subset.Error,
            scale=:log,
            label=method,
            markersize=3,
            shape=data_markers1[plot_idx],
            title="(c)",
            titleloc=:left,
            titlefont=font(10),
            xlabel="Execution time (sc, Log)",
            ylabel="Error: 2-norm (Log)",
            legend=false,
            colour = ifelse("Julia" in unique(method_subset.Language), :red, :blue))
    else
        plot!(method_subset.ExecutionTime,
            method_subset.Error,
            label=method,
            markersize=3,
            shape=data_markers1[plot_idx],
            colour = ifelse("Julia" in unique(method_subset.Language), :red, :blue))
    end
    display(p3)
end

l1 = @layout [[grid(2, 1)] b{0.5w}]
Plt1D = plot(p1, p3, p2,
             layout=l1)
savefig(Plt1D, "Plt1D.svg")
savefig(Plt1D, "Plt1D.png")

filter!(:Method => x -> x != "J-3", sir_benchmark)
data_markers2 = [:circle, :square, :utriangle, :star, :dtriangle, :ltriangle, :rtriangle, :circle, :utriangle, :circle, :diamond, :square]
data_colours2 = [:red, :red, :green, :green, :green, :green, :green, :green, :blue, :blue, :blue, :blue]
p4 = Nothing

for (plot_idx, method) in enumerate(unique(sir_benchmark.Method))
    method_subset = filter(:Method => x -> x == method, sir_benchmark)
    if plot_idx == 1
        p4 = plot(method_subset.ExecutionTime,
            method_subset.Error,
            scale=:log,
            label=method,
            markersize=3,
            shape=data_markers2[plot_idx],
            title="(a)",
            titleloc=:left,
            titlefont=font(10),
            xlabel="Execution time (sc, Log)",
            ylabel="Error: 2-norm (Log)",
            legendposition=:outerright,
            legendfontsize=6,
            legendtitle="Solver Method",
            legendtitlefontsize=7,
            colour=data_colours2[plot_idx])
    else
        plot!(method_subset.ExecutionTime,
            method_subset.Error,
            label=method,
            markersize=3,
            shape=data_markers2[plot_idx],
            colour=data_colours2[plot_idx])
        end
    display(p4)
end

filter!(:Error => x -> x != "NA", lotka_volterra_benchmark)
lotka_volterra_benchmark.Error = parse.(Float64, lotka_volterra_benchmark.Error)
p5 = Nothing

for (plot_idx, method) in enumerate(unique(lotka_volterra_benchmark.Method))
    method_subset = filter(:Method => x -> x == method, lotka_volterra_benchmark)
    if plot_idx == 1
        p5 = plot(method_subset.ExecutionTime,
            method_subset.Error,
            scale=:log,
            label=method,
            markersize=3,
            shape=data_markers1[plot_idx],
            title="(b)",
            titleloc=:left,
            titlefont=font(10),
            xlabel="Execution time (sc, Log)",
            ylabel="Error: 2-norm (Log)",
            legend=false,
            colour = ifelse("Julia" in unique(method_subset.Language), :red, :blue))
    else
        plot!(method_subset.ExecutionTime,
            method_subset.Error,
            label=method,
            markersize=3,
            shape=data_markers1[plot_idx],
            colour = ifelse("Julia" in unique(method_subset.Language), :red, :blue))
    end
    display(p5)
end

p6 = plot(DynLV[:, 1], Matrix(DynLV[:, 2:4]), xlabel="Time", ylabel="Abundance of species",
    thickness_scaling=1, framestyle=:box, labels=["X1" "X2" "X3"],
    title="(c)", titleloc=:left, titlefont=font(10))

l2 = @layout [b{0.6h}; grid(1, 2)]
PltMD = plot(p4, p5, p6,
             layout=l2,
             size=(600, 500))
savefig(PltMD, "PltMD.svg")
savefig(PltMD, "PltMD.png")

#### plot randoms

p7 = Nothing

for (plot_idx, method) in enumerate(unique(random_params_benchmark.Method))
    method_subset = filter(:Method => x -> x == method, random_params_benchmark)
    if plot_idx == 1
        p7 = scatter(method_subset.ExecutionTime,
            method_subset.Error,
            scale=:log,
            label=method,
            markersize=3,
            shape=data_markers1[plot_idx],
            title="(a)",
            titleloc=:left,
            titlefont=font(10),
            xlabel="Execution time (sc, Log)",
            ylabel="Error: 2-norm (Log)",
            legendposition=:bottomleft,
            colour = ifelse("Julia" in unique(method_subset.Language), :red, :blue))
    else
        scatter!(method_subset.ExecutionTime,
            method_subset.Error,
            label=method,
            markersize=3,
            shape=:circle)
    end
    display(p7)
end

p8 = @df random_params_benchmark boxplot(:Method, :Error,
    yscale=:log,
    ylabel="Error: 2-norm (Log)",
    c=:black,
    fillcolor=:white,
    legend=false,
    title="(b)",
    titleloc=:left,
    titlefont=font(10))

p9 = @df random_params_benchmark boxplot(:Method, :ExecutionTime,
    yscale=:log,
    ylabel="Execution time (sc, Log)",
    c=:black,
    fillcolor=:white,
    legend=false,
    title="(c)",
    titleloc=:left,
    titlefont=font(10))

l3 = @layout [b{0.5w} grid(2, 1)]
PltRnd = plot(p7, p8, p9,
    layout=l3,
    size=(800, 500))
savefig(PltRnd, "PltRnd.png")
savefig(PltRnd, "PltRnd.svg")
