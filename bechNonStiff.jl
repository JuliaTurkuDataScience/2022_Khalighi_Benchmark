using LinearAlgebra
using BenchmarkTools
using FdeSolver
using FractionalDiffEq, Plots
using SpecialFunctions
using CSV, DataFrames

push!(LOAD_PATH, "./FDEsolver")
Mdata = CSV.read("BenchNonStiff.csv", DataFrame, header = 0) #it should be based on the directory of CSV files on your computer
## inputs
tSpan = [0, 1]     # [intial time, final time]
y0 = 0             # intial value
β = 0.5            # order of the derivative

# Equation
par = β
F(t, y, par) = (40320 ./ gamma(9 - par) .* t .^ (8 - par) .- 3 .* gamma(5 + par / 2)
           ./ gamma(5 - par / 2) .* t .^ (4 - par / 2) .+ 9/4 * gamma(par + 1) .+
           (3 / 2 .* t .^ (par / 2) .- t .^ 4) .^ 3 .- y .^ (3 / 2))
# Jacobian
JF(t, y, par) = -(3 / 2) .* y .^ (1 / 2)

Exact(t) = t.^8 - 3 * t .^ (4 + β / 2) + 9 / 4 * t.^β
## Check the results after the second run
E1 = Float64[]
T1 = Float64[]
E2 = Float64[]
T2 = Float64[]
h = Float64[]

for n in range(3, 8)
    println("n: $n")
    h = 2.0^-n # step size
    t1= @benchmark FDEsolver(F, $(tSpan), $(y0), $(β), $(par) , h=$(h), tol=1e-6) seconds=1
    t2= @benchmark FDEsolver(F, $(tSpan), $(y0), $(β), $(par), JF = JF, h=$(h), tol=1e-8) seconds=1

    tt1, y1 = FDEsolver(F, tSpan, y0, β, par, h=h, tol=1e-6)
    tt2, y2= FDEsolver(F, tSpan, y0, β, par, JF = JF, h=h, tol=1e-8)

    ery1=norm(y1 - map(Exact, tt1), 2)
    ery2=norm(y2 - map(Exact, tt2), 2)

    push!(E1, ery1)
    push!(E2, ery2)

    # convert from nano seconds to seconds
    push!(T1, minimum(t1).time / 10^9)
    push!(T2, minimum(t2).time / 10^9)
end

plot(T1, E1, xscale = :log, yscale = :log, linewidth = 2, markersize = 5,
     label = "Julia PC (FdeSolver.jl)", shape = :circle, xlabel="Time (sc, Log)", ylabel="Error: 2-norm (Log)",
     thickness_scaling = 1,legend_position= :bottomleft, c=:blue,fc=:transparent,framestyle=:box, mc=:white)
plot!(T2, E2,linewidth = 2, markersize = 5,label = "Julia NR (FdeSolver.jl)", shape = :rect, color = :blue, mc=:white)
plot!(Mdata[:, 1], Mdata[:, 5], linewidth = 2, markersize = 5,label = "Matlab PI-EX (Garrappa)",shape = :rtriangle, color = :red, mc=:white)
plot!(Mdata[:, 2], Mdata[:, 6], linewidth = 2, markersize = 5,label = "Matlab PI-PC (Garrappa)", shape = :circle, color = :red, mc=:white)
plot!(Mdata[:, 3], Mdata[:, 7], linewidth = 2, markersize = 5,label = "Matlab PI-IM1 (Garrappa)", shape = :diamond, color = :red, mc=:white)
pNonStiff=plot!(Mdata[:, 4], Mdata[:, 8], linewidth = 2, markersize = 5,label = "Matlab PI-IM2 (Garrappa)", shape = :rect, color = :red, mc=:white)



savefig(pNonStiff,"NonStiff.svg")
