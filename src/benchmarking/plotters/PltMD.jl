# Errors versus time of execution of Julia and Matlab codes
# for solving for multi-dimensional systems

# Non-oscillation example.
p4 = plot(sir_benchmark.ExecutionTime,
    sir_benchmark.Error, scale=:log,
    group=sir_benchmark.Label,
    shape=sir_benchmark.Shape, markersize=3,
    colour=sir_benchmark.Colour,markerstrokewidth=0.3,ms=3.5,
    title="(a) Non-oscillation example", titleloc=:left,
    xlabel=time_label, ylabel=error_label,
    legendposition=:outerbottomright, legendfontsize=9,
    legendtitle="Method", legendtitlefontsize=10)

# Sharp oscillation example
p5 = plot(lotka_volterra_benchmark.ExecutionTime,
    lotka_volterra_benchmark.Error, scale=:log,
    group=lotka_volterra_benchmark.Label,
    shape=lotka_volterra_benchmark.Shape, markersize=3,
    colour=lotka_volterra_benchmark.Colour,
    title="(b) Sharp oscillation example", titleloc=:left,
    xlabel=time_label, ylabel=error_label,markerstrokewidth=0.3,ms=3.5,
    legend=false)

# define plot layout
l2 = @layout [a{0.5h}; b{0.8w} _]

# make multipanel plot
PltMD = plot(p4, p5,
    layout=l2,
    size=(800, 800))

# save plot as svg and png files in the "figures" directory
savefig(PltMD, joinpath(output_dir, "PltMD.svg"))
savefig(PltMD, joinpath(output_dir, "PltMD.png"))


# Illustration of the sharp oscillation dynamics
p6 = plot(DynSIR[:, 1], Matrix(DynSIR[:, 2:4]), xlabel="Time", ylabel="Fraction of population",
              labels=["S" "I" "R"],
                title="(a) Dynamics of non-oscillation example", titleloc=:left, titlefont=font(10))
# Illustration of the non-oscillation dynamics
p7 = plot(DynLV[:, 1], Matrix(DynLV[:, 2:4]), xlabel="Time", ylabel="Abundance of species",
         labels=["X1" "X2" "X3"],
        title="(b) Dynamics of sharp oscillation example", titleloc=:left, titlefont=font(10))

# define plot layout
l = @layout [grid(1, 2)]

# make multipanel plot
PltDynMD = plot(p6, p7,
            layout=l,
            size=(750, 450))

savefig(PltDynMD, joinpath(output_dir, "PltDynMD.svg"))
savefig(PltDynMD, joinpath(output_dir, "PltDynMD.png"))
