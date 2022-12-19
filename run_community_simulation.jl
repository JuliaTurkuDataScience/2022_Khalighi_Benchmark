using FdeSolver
using SpecialFunctions, Statistics
using Plots, ColorTypes, LaTeXStrings

source_dir = joinpath(@__DIR__, "src/community_simulation")
output_dir = joinpath(@__DIR__, "results/community_simulation")

include(joinpath(source_dir, "dynamics.jl"))
savefig(p111, joinpath(output_dir, "fig3ploscb1.svg"))
savefig(p222, joinpath(output_dir, "fig3ploscb2.svg"))

include(joinpath(source_dir, "resistance.jl"))
savefig(P, joinpath(output_dir, "myplot.svg"))