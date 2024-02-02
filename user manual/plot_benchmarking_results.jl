using Plots, CSV, DataFrames # for working with data and plotting
using StatsPlots             # for making boxplots
using EasyFit, GLM           # for plotting linear line in the background
using LaTeXStrings           # for math in plots

source_dir = joinpath(@__DIR__, "src/benchmarking/plotters")
# directory where data is read from (the "data" directory)
data_dir = joinpath(@__DIR__, "data")
# directory where figures are saved into (the "figures" directory)
output_dir = joinpath(@__DIR__, "results/benchmarking")

# load the benchmarking results into several dataframes

# data for plot 1
nonstiff_benchmark = CSV.read(joinpath(data_dir, "nonstiff_benchmark.csv"), DataFrame, header=1)

# data for plot 2, with 1 extreme outlier removed
stiff_benchmark = CSV.read(joinpath(data_dir, "stiff_benchmark.csv"), DataFrame, header=1)
filter!(:Error => x -> x < 10^5, stiff_benchmark)

# data for plot 3
harmonic_benchmark = CSV.read(joinpath(data_dir, "harmonic_benchmark.csv"), DataFrame, header=1)

# data for plot 4, excluding solver method J-3
sir_benchmark = CSV.read(joinpath(data_dir, "sir_benchmark.csv"), DataFrame, header=1)
filter!(:Method => x -> x != "J-3", sir_benchmark)

# data for plot 5, with 1 missing value removed
lotka_volterra_benchmark = CSV.read(joinpath(data_dir, "lotka_volterra_benchmark.csv"), DataFrame, header=1)
filter!(:Error => x -> x != "NA", lotka_volterra_benchmark)
lotka_volterra_benchmark.Error = parse.(Float64, lotka_volterra_benchmark.Error)

# data for plot 6
DynLV = CSV.read(joinpath(data_dir, "DynLV.csv"), DataFrame, header=1)
DynSIR = CSV.read(joinpath(data_dir, "DynSIR.csv"), DataFrame)

# data for plot 7, 8 and 9
random_params_benchmark = CSV.read(joinpath(data_dir, "random_params_benchmark.csv"), DataFrame, header=1)

# make a dictionary containing the label, shape and colour aesthetics for the different solver methods
aesthetics = Dict("J-PC" => ("J1", :circle, "firebrick3"),
                  "J-NR" => ("J2", :square, "hotpink"),
                  "M-PI-PC" => ("M1", :circle, "royalblue3"),
                  "M-PI-IM2" => ("M2", :square, "skyblue2"),
                  "M-PI-IM1" => ("M3", :diamond, "cyan3"),
                  "M-PI-EX" => ("M4", :rtriangle, "mediumblue"),
                  "J-PECE" => ("J3", :circle, "darkorange"),
                  "J-PI-EX" => ("J4", :hexagon, "darkorange"),
                  "J-GL" => ("J5", :star5, "darkorange"),
                  "J-Euler" => ("J6", :utriangle, "darkorange"),
                  "J-NonLinearAlg" => ("J7", :star5, "darkorange"),
                  "J-FLMMBDF" => ("J8", :utriangle, "darkorange"),
                  "J-FLMMNewtonG" => ("J9", :dtriangle, "darkorange"),
                  "J-FLMMTrap" => ("J10", :pentagon, "darkorange"))

# add label, shape and colour aesthetics as columns to the respective dataframes
for df in [nonstiff_benchmark, stiff_benchmark, harmonic_benchmark, lotka_volterra_benchmark, sir_benchmark, random_params_benchmark]

    df[!, :Label] .= ""
    df[!, :Shape] .= :circle
    df[!, :Colour] .= ""
    df.Label .= map(x -> get(aesthetics, x, 0)[1], df.Method)
    df.Shape .= map(x -> get(aesthetics, x, 0)[2], df.Method)
    df.Colour .= map(x -> get(aesthetics, x, 0)[3], df.Method)

end

# set x and y axis labels for the plots
error_label = L"\textrm{Error}= \Vert x - \overline{x} \;\Vert ^2"
time_label = "Execution Time (Sec)"

# make plots from 1D benchmark by running Plt1D.jl script
include(joinpath(source_dir, "Plt1D.jl"))

# make plots from MD benchmark by running PltMD.jl script
include(joinpath(source_dir, "PltMD.jl"))

# plot benchmark with random params by running PltRnd.jl script
include(joinpath(source_dir, "PltRnd.jl"))

# all figures are saved in the "results" directory
