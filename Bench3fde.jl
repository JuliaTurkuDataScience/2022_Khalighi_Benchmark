using LinearAlgebra
using BenchmarkTools
using FdeSolver
using FractionalDiffEq, Plots
using SpecialFunctions
using CSV, DataFrames

## insert data
#it should be based on the directory of CSV files on your computer
push!(LOAD_PATH, "./FDEsolver")
Mdata = Matrix(CSV.read("Bench3fde.csv", DataFrame, header = 0)) #Benchmark from Matlab


# Parameters
tSpan = [0, 5]         # Time Span
y0 = [1, 0.5, 0.3]     # Initial values
α = [0.5, 0.2, 0.6]    # Order of derivation

# Definition of the System
function F(t, y)

    F1 = 1 / sqrt(pi) * (((y[2] - 0.5) * (y[3] - 0.3))^(1 / 6) + sqrt(t))
    F2 = gamma(2.2) * (y[1] - 1)
    F3 = gamma(2.8) / gamma(2.2) * (y[2] - 0.5)

    return [F1, F2, F3]

end


function JF(t, y)
    # System equation
    J11 = 0
    J12 = (y[2] - 0.5).^(-5/6) .* (y[3] - 0.3).^(1/6) / (6* sqrt(pi))
    J13 = (y[2] - 0.5).^(1/6) .* (y[3] - 0.3).^(-5/6) / (6* sqrt(pi))
    J21 =  gamma(2.2)
    J22 =  0
    J23 =  0
    J31 =  0
    J32 =  gamma(2.8) / gamma(2.2)
    J33 =  0

    J = [J11 J12 J13
         J21 J22 J23
         J31 J32 J33]
    return J
end

##scifracx
function FF!(dy, y, p, t)

    # System equation
    dy[1] = 1 / sqrt(pi) * (((y[2] - 0.5) * (y[3] - 0.3))^(1 / 6) + sqrt(t))
    dy[2] = gamma(2.2) * (y[1] - 1)
    dy[3] = gamma(2.8) / gamma(2.2) * (y[2] - 0.5)

end

Tspan = (0, 5)

y00 = [1, 0.5, 0.3]
prob = FODESystem(FF!, α, y00, Tspan)

# Benchmarking
E1 = Float64[];T1 = Float64[];E2 = Float64[];T2 = Float64[]
E3 = Float64[];T3 = Float64[];E4 = Float64[];T4 = Float64[]
E5 = Float64[];T5 = Float64[];E6 = Float64[];T6 = Float64[]
E7 = Float64[];T7 = Float64[];E8 = Float64[];T8 = Float64[]
E9 = Float64[];T9 = Float64[];h = Float64[]


for n in range(3,7)
    println("n: $n")# to print out the current step of runing
    h = 2.0^-n #stepsize of computting
        #computting the time
    t1= @benchmark FDEsolver(F, $(tSpan), $(y0), $(α), h=$(h)) seconds=1
    t2= @benchmark FDEsolver(F, $(tSpan), $(y0), $(α), JF = JF, h=$(h), tol=1e-8, itmax=100) seconds=1
    t4= @benchmark solve($(prob), $(h), $(PIEX())) seconds=1
    t5= @benchmark solve($(prob), $(h), $(NonLinearAlg())) seconds=1
    t6 = @benchmark solve($(prob), $(h), FLMMBDF()) seconds=1
    t7 = @benchmark solve($(prob), $(h), FLMMNewtonGregory()) seconds=1
    t8 = @benchmark solve($(prob), $(h), FLMMTrap()) seconds=1
    t9 = @benchmark solve($(prob), $(h), PECE()) seconds=1

    # convert from nano seconds to seconds
    push!(T1, minimum(t1).time / 10^9)
    push!(T2, minimum(t2).time / 10^9)
    push!(T4, minimum(t4).time / 10^9)
    push!(T5, minimum(t5).time / 10^9)
    push!(T6, minimum(t6).time / 10^9)
    push!(T7, minimum(t7).time / 10^9)
    push!(T8, minimum(t8).time / 10^9)
    push!(T9, minimum(t9).time / 10^9)
    #computting the error
    TT, y1 = FDEsolver(F, tSpan, y0, α, h=h)
    _, y2 = FDEsolver(F, tSpan, y0, α, JF = JF, h=h, tol=1e-8, itmax=100)
    y4 =  solve(prob, h, PIEX())
    y5 =  solve(prob, h, NonLinearAlg())
    y6 = solve(prob, h, FLMMBDF())
    y7 = solve(prob, h, FLMMNewtonGregory())
    y8 = solve(prob, h, FLMMTrap())
    y9 = solve(prob, h, PECE())

    Yexact = [TT .+ 1, TT.^1.2 .+ 0.5 , TT.^1.8 .+ 0.3]
    Yex=reduce(vcat,transpose.(Yexact))

    ery1=norm(y1' .- Yex,2)
    ery2=norm(y2' .- Yex,2)
    ery4=norm(y4.u .- Yex,2)
    ery5=norm(y5.u .- Yex,2)
    ery6=norm(y6.u .- Yex,2)
    ery7=norm(y7.u .- Yex,2)
    ery8=norm(y8.u .- Yex,2)
    ery9=norm(y9.u .- Yex,2)

    push!(E1, ery1)
    push!(E2, ery2)
    push!(E4, ery4)
    push!(E5, ery5)
    push!(E6, ery6)
    push!(E7, ery7)
    push!(E8, ery8)
    push!(E9, ery9)

end

## plotting
# plot Matlab and FdeSolver outputs
plot(T1, E1, xscale = :log, yscale = :log, linewidth = 2, markersize = 5,
     label = "Julia PC (FdeSolver.jl)", shape = :circle, xlabel="Time (sc, Log)", ylabel="Error: 2-norm (Log)",
     thickness_scaling = 1,legend_position= :right, c=:blue,fc=:transparent,framestyle=:box, mc=:white)
plot!(T2, E2,linewidth = 2, markersize = 5,label = "Julia NR (FdeSolver.jl)", shape = :rect, color = :blue, mc=:white)
plot!(Mdata[2:end, 1], Mdata[2:end, 5], linewidth = 2, markersize = 5,label = "Matlab PI-EX (Garrappa)",shape = :rtriangle, color = :red, mc=:white)
plot!(Mdata[:, 2], Mdata[:, 6], linewidth = 2, markersize = 5,label = "Matlab PI-PC (Garrappa)", shape = :circle, color = :red, mc=:white)
plot!(Mdata[:, 3], Mdata[:, 7], linewidth = 2, markersize = 5,label = "Matlab PI-IM1 (Garrappa)", shape = :diamond, color = :red, mc=:white)
p3fde=plot!(Mdata[:, 4], Mdata[:, 8], linewidth = 2, markersize = 5,label = "Matlab PI-IM2 (Garrappa)", shape = :rect, color = :red, mc=:white)


savefig(p3fde,"p3fde.svg")

# plot Scifracx outputs
plot!(T5, E5, xscale = :log, yscale = :log, linewidth = 5, label = "Julia NonLinearAlg (FractionalDiffEq.jl)", shape = :star5, color = :purple, mc=:white)
plot!(T9, E9,linewidth = 2,  markersize = 5, label = "Julia PECE (FractionalDiffEq.jl)", shape = :diamond, color = :purple, mc=:white)
plot!(T4, E4,linewidth = 2, markersize = 5, label = "Julia PI-EX (FractionalDiffEq.jl)", shape = :hexagon, color = :purple, mc=:white)
plot!(T6, E6,linewidth = 2,markersize = 5,  label = "Julia FLMMBDF (FractionalDiffEq.jl)", shape = :xcross, color = :purple, mc=:white)
plot!(T7, E7,linewidth = 2,markersize = 5,  label = "Julia FLMMNewtonGregory (FractionalDiffEq.jl)", shape = :utriangle, color = :purple, mc=:white)
p3fde2=plot!(T8, E8,linewidth = 2, markersize = 5, label = "Julia FLMMTrap (FractionalDiffEq.jl)", shape = :pentagon, color = :purple, mc=:white)

savefig(p3fde2,"p3fde2.png")
