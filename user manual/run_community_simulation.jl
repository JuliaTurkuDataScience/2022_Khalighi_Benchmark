# plot of the dynamics of microbial communities under perturbations and memory effects
# Ref:https://doi.org/10.1371/journal.pcbi.1009396

using FdeSolver
using SpecialFunctions, Statistics
using Plots, ColorTypes, LaTeXStrings

source_dir = joinpath(@__DIR__, "src/community_simulation")
output_dir = joinpath(@__DIR__, "results/community_simulation")

include(joinpath(source_dir, "Pulse_Perturbations.jl"))
savefig(P, joinpath(output_dir, "myplot.svg"))
savefig(P, joinpath(output_dir, "myplot.png"))

include(joinpath(source_dir, "Periodic_Perturbations.jl"))
savefig(p111, joinpath(output_dir, "fig3ploscb1.svg"))
savefig(p222, joinpath(output_dir, "fig3ploscb2.svg"))
savefig(p111, joinpath(output_dir, "fig3ploscb1.png"))
savefig(p222, joinpath(output_dir, "fig3ploscb2.png"))
