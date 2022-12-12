using Plots, CSV, DataFrames
using StatsPlots
using EasyFit, GLM # for plotting linear line in the background
using LaTeXStrings # for math in plots

data_dir =  joinpath(dirname(@__DIR__), "data")
output_dir = joinpath(@__DIR__, "figures")

# load the benchmarking results
nonstiff_benchmark = CSV.read(joinpath(data_dir, "nonstiff_benchmark.csv"), DataFrame, header=1)

stiff_benchmark = CSV.read(joinpath(data_dir, "stiff_benchmark.csv"), DataFrame, header=1)
filter!(:Error => x -> x < 10^5, stiff_benchmark)

harmonic_benchmark = CSV.read(joinpath(data_dir, "harmonic_benchmark.csv"), DataFrame, header=1)

lotka_volterra_benchmark = CSV.read(joinpath(data_dir, "lotka_volterra_benchmark.csv"), DataFrame, header=1)
filter!(:Error => x -> x != "NA", lotka_volterra_benchmark)
lotka_volterra_benchmark.Error = parse.(Float64, lotka_volterra_benchmark.Error)

sir_benchmark = CSV.read(joinpath(data_dir, "sir_benchmark.csv"), DataFrame, header=1)
filter!(:Method => x -> x != "J-3", sir_benchmark)

random_params_benchmark = CSV.read(joinpath(data_dir, "random_params_benchmark.csv"), DataFrame, header=1)
DynLV = CSV.read(joinpath(data_dir, "DynLV.csv"), DataFrame, header=1)

easthetics = Dict("J-PC" => ("J1", :circle, "firebrick3"),
                  "J-NR" => ("J2", :square, "hotpink"),
                  "M-PI-PC" => ("M1", :circle, "royalblue3"),
                  "M-PI-IM2" => ("M2", :square, "skyblue2"),
                  "M-PI-IM1" => ("M3", :diamond, "cyan3"),
                  "M-PI-EX" => ("M4", :rtriangle, "mediumblue"),
                  "J-PECE" => ("J3", :circle, "darkorange"),
                  "J-PI-EX" => ("J4", :hexagon, "darkorange"),
                  "J-NonLinearAlg" => ("J5", :star5, "darkorange"),
                  "J-FLMMBDF" => ("J6", :utriangle, "darkorange"),
                  "J-FLMMNewtonG" => ("J7", :dtriangle, "darkorange"),
                  "J-FLMMTrap" => ("J8", :pentagon, "darkorange"))

for df in [nonstiff_benchmark, stiff_benchmark, harmonic_benchmark, lotka_volterra_benchmark, sir_benchmark, random_params_benchmark]

    df[!, :Label] .= ""
    df[!, :Shape] .= ""
    df[!, :Colour] .= ""
    df.Label .= map(x -> get(easthetics, x, 0)[1], df.Method)
    df.Shape .= map(x -> get(easthetics, x, 0)[2], df.Method)
    df.Colour .= map(x -> get(easthetics, x, 0)[3], df.Method)

end

# set constants
error_label = L"\textrm{Error}= \Vert x - \overline{x} \;\Vert ^2"
time_label = "Execution Time (Sec)"

### plot Examples
include(joinpath(@__DIR__, "Plt1D.jl"))
include(joinpath(@__DIR__, "PltMD.jl"))

#### plot randoms
include(joinpath(@__DIR__, "PltRnd.jl"))
