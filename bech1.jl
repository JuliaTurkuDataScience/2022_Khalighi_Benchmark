using LinearAlgebra
using BenchmarkTools
using FdeSolver
using FractionalDiffEq, Plots
using SpecialFunctions
using CSV, DataFrames


## inputs
tSpan = [0, 1]     # [intial time, final time]
y0 = 0             # intial value
β = 0.5            # order of the derivative
h=2^-5

# Equation
par = β
F(t, y, par) = (40320 ./ gamma(9 - par) .* t .^ (8 - par) .- 3 .* gamma(5 + par / 2)
           ./ gamma(5 - par / 2) .* t .^ (4 - par / 2) .+ 9/4 * gamma(par + 1) .+
           (3 / 2 .* t .^ (par / 2) .- t .^ 4) .^ 3 .- y .^ (3 / 2))
# Jacobian
JF(t, y, par) = -(3 / 2) .* y .^ (1 / 2)

Exact(t) = t.^8 - 3 * t .^ (4 + β / 2) + 9 / 4 * t.^β

#########scifracX
FF!(t, y) = (40320 ./ gamma(9 - 0.5 ) .* t .^ (8 - 0.5 ) .- 3 .* gamma(5 + 0.5  / 2)
               ./ gamma(5 - 0.5  / 2) .* t .^ (4 - 0.5  / 2) .+ 9/4 * gamma(0.5  + 1) .+
               (3 / 2 .* t .^ (0.5  / 2) .- t .^ 4) .^ 3 .- y .^ (3 / 2))

Tspan = (0, 1)

prob = SingleTermFODEProblem(FF!, β, y0, Tspan);
##
E1 = Float64[]
T1 = Float64[]
E2 = Float64[]
T2 = Float64[]
E3 = Float64[]
T3 = Float64[]
E4 = Float64[]
T4 = Float64[]
# E5 = Float64[]
# T5 = Float64[]
# E6 = Float64[]
# T6 = Float64[]
h = Float64[]

for n in range(3, length=6)
    println("n: $n")
    h = 2.0^-n # step size
    t1= @benchmark FDEsolver(F, $(tSpan), $(y0), $(β), $(par) , h=$(h)) seconds=1
    t2= @benchmark FDEsolver(F, $(tSpan), $(y0), $(β), $(par), JF = JF, h=$(h)) seconds=1
    # t3= @benchmark solve($(prob), $(h), $(GL())) seconds=1
    # t4= @benchmark solve($(prob), $(h), $(PIEX())) seconds=1
    # t5= @benchmark solve($(prob), $(h), PECE()) seconds=1

    tt1, y1 = FDEsolver(F, tSpan, y0, β, par, h=h)
    tt2, y2= FDEsolver(F, tSpan, y0, β, par, JF = JF, h=h)
    # y3=  solve(prob, h, GL())
    # y4=  solve(prob, h, PIEX())
    # y5 = solve(prob, h, PECE())

    ery1=norm(y1 - map(Exact, tt1), 2)
    ery2=norm(y2 - map(Exact, tt2), 2)
    # ery3=norm(y3.u - map(Exact, y3.t), 2)
    # ery4=norm(y4.u - map(Exact, y4.t), 2)
    # ery5=norm(y5.u - map(Exact, y5.t), 2)

    push!(E1, ery1)
    push!(E2, ery2)
    # push!(E3, ery3)
    # push!(E4, ery4)
    # push!(E5, ery5)

    # convert from nano seconds to seconds
    push!(T1, minimum(t1).time / 10^9)
    push!(T2, minimum(t2).time / 10^9)
    # push!(T3, minimum(t3).time / 10^9)
    # push!(T4, minimum(t4).time / 10^9)
    # push!(T5, minimum(t5).time / 10^9)
end

push!(LOAD_PATH, "./FDEsolver")
Mdata = CSV.read("Data_Matlab_1D.csv", DataFrame, header = 0) #it should be based on the directory of CSV files on your computer

# plot(T3, E3, linewidth = 5,yaxis=:log, xscale = :log, label = "Julia GL (FractionalDiffEq.jl)", xlabel="Time (sc, Log)", ylabel="Error: 2-norm (Log)")
# plot(Mdata[!, 3], Mdata[!, 6], linewidth = 5,
     # label = "Matlab PI-EX (Garrappa)")
# plot!(T4, E4,linewidth = 5, label = "Julia PI-EX (FractionalDiffEq.jl)")

# plot(T3, E3, linewidth = 5, yaxis=:log, xscale = :log, label = "Julia GL (FractionalDiffEq.jl)", xlabel="Time (sc, Log)", ylabel="Error: 2-norm (Log)")
plot(Mdata[!, 3], Mdata[!, 6], xscale = :log, yscale = :log,linewidth = 5, label = "Matlab PI-EX (Garrappa)", xlabel="Time (sc, Log)", ylabel="Error: 2-norm (Log)")
# plot!(T5, E5, linewidth = 5,yaxis=:log, xscale = :log, label = "Julia PECE (FractionalDiffEq.jl)")
# plot!(T6, E6, linewidth = 5,yaxis=:log, xscale = :log, label = "Julia AtanganaSeda (FractionalDiffEq.jl)")
plot!(Mdata[!, 1], Mdata[!, 4], linewidth = 5, yscale = :log, label = "Matlab PI-PC (Garrappa)")
plot!(T1, E1, linewidth = 5, label = "Julia PI-PC (FdeSolver.jl)")
plot!(Mdata[!, 2], Mdata[!, 5], linewidth = 5, yscale = :log, label = "Matlab P-IM (Garrappa)")
plot!(T2, E2, linewidth = 5, label = "Julia P-IM (FdeSolver.jl)")
