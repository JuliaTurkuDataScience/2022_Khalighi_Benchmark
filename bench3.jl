using LinearAlgebra
using BenchmarkTools
using FdeSolver
using FractionalDiffEq, Plots
using SpecialFunctions
using CSV, DataFrames


## inputs
I0 = 0.1             # intial value of infected
tSpan = [0, 100]       # [intial time, final time]
y0 = [1 - I0, I0, 0]   # initial values [S0,I0,R0]
α = [.9, .8, 1]          # order of derivatives
h = 0.02                # step size of computation (default=0.01)

## ODE model
par = [0.4, 0.04] # parameters [β, recovery rate]

function F(t, y, par)

    # parameters
    β = par[1]    # infection rate
    γ = par[2]    # recovery rate

    S = y[1]   # Susceptible
    I = y[2]   # Infectious
    R = y[3]   # Recovered

    # System equation
    dSdt = - β .* S .* I
    dIdt = β .* S .* I .- γ .* I
    dRdt = γ .* I

    return [dSdt, dIdt, dRdt]

end

## Jacobian of ODE system
function JF(t, y, par)

    # parameters
    β = par[1]     # infection rate
    γ = par[2]     # recovery rate

    S = y[1]    # Susceptible
    I = y[2]    # Infectious
    R = y[3]    # Recovered

    # System equation
    J11 = - β * I
    J12 = - β * S
    J13 =  0
    J21 =  β * I
    J22 =  β * S - γ
    J23 =  0
    J31 =  0
    J32 =  γ
    J33 =  0

    J = [J11 J12 J13
         J21 J22 J23
         J31 J32 J33]

    return J

end

##scifracx
function SIR(dy, y, p, t)

    # System equation
    dy[1] = - .4 * y[1] * y[2]
    dy[2] = .4 * y[1] * y[2] - .04 * y[2]
    dy[3] = .04 * y[2]
        return dy
end

Tspan = (0, 100)

y00 = [1 - I0; I0; 0]
prob = FODESystem(SIR, α, y00, Tspan)

t, Yex= FDEsolver(F, tSpan, y0, α, par, JF = JF, h=2^-9)
Mdata[!, 7], Mdata[!, 8] # Solution with a fine step size

E1 = Float64[]
T1 = Float64[]
E2 = Float64[]
T2 = Float64[]
E3 = Float64[]
T3 = Float64[]
E4 = Float64[]
T4 = Float64[]
E5 = Float64[]
T5 = Float64[]
E6 = Float64[]
T6 = Float64[]
E7 = Float64[]
T7 = Float64[]
E8 = Float64[]
T8 = Float64[]
E9 = Float64[]
T9 = Float64[]
h = Float64[]

for n in range(2, length=6)
    println("n: $n")
    h = 2.0^-n
    t1= @benchmark FDEsolver(F, $(tSpan), $(y0), $(α), $(par) , h=$(h)) seconds=1
    t2= @benchmark FDEsolver(F, $(tSpan), $(y0), $(α), $(par), JF = JF, h=$(h)) seconds=1
    t3= @benchmark solve($(prob), $(h), $(GL())) seconds=1
    t4= @benchmark solve($(prob), $(h), $(PIEX())) seconds=1
    t5= @benchmark solve($(prob), $(h), $(NonLinearAlg())) seconds=1
    t6 = @benchmark solve($(prob), $(h), FLMMBDF()) seconds=1
    t7 = @benchmark solve($(prob), $(h), FLMMNewtonGregory()) seconds=1
    t8 = @benchmark solve($(prob), $(h), FLMMTrap()) seconds=1
    t9 = @benchmark solve($(prob), $(h), PECE()) seconds=1

    _, y1 = FDEsolver(F, tSpan, y0, α, par , h=h)
    _, y2 = FDEsolver(F, tSpan, y0, α, par, JF = JF, h=h)
    y3 =  solve(prob, h, GL())
    y4 =  solve(prob, h, PIEX())
    y5 =  solve(prob, h, NonLinearAlg())
    y6 = solve(prob, h, FLMMBDF())
    y7 = solve(prob, h, FLMMNewtonGregory())
    y8 = solve(prob, h, FLMMTrap())
    y9 = solve(prob, h, PECE())

    ery1=norm(y1 .- Yex[1:2^(9-n):end,:],2)
    ery2=norm(y2 .- Yex[1:2^(9-n):end,:],2)
    ery3=norm(y3.u' .- Yex[1:2^(9-n):end,:],2)
    ery4=norm(y4.u' .- Yex[1:2^(9-n):end,:],2)
    ery5=norm(y5.u' .- Yex[1:2^(9-n):end,:],2)
    ery6=norm(y6.u' .- Yex[1:2^(9-n):end,:],2)
    ery7=norm(y7.u' .- Yex[1:2^(9-n):end,:],2)
    ery8=norm(y8.u' .- Yex[1:2^(9-n):end,:],2)
    ery9=norm(y9.u' .- Yex[1:2^(9-n):end,:],2)

    push!(E1, ery1)
    push!(E2, ery2)
    push!(E3, ery3)
    push!(E4, ery4)
    push!(E5, ery5)
    push!(E6, ery6)
    push!(E7, ery7)
    push!(E8, ery8)
    push!(E9, ery9)
    # convert from nano seconds to seconds
    push!(T1, minimum(t1).time / 10^9) #why not mean?
    push!(T2, minimum(t2).time / 10^9)
    push!(T3, minimum(t3).time / 10^9)
    push!(T4, minimum(t4).time / 10^9)
    push!(T5, minimum(t5).time / 10^9)
    push!(T6, minimum(t6).time / 10^9)
    push!(T7, minimum(t7).time / 10^9)
    push!(T8, minimum(t8).time / 10^9)
    push!(T9, minimum(t9).time / 10^9)
end

push!(LOAD_PATH, "./FDEsolver")
Mdata = CSV.read("Data_Matlab_SIR.csv", DataFrame, header = 0) #it should be based on the directory of CSV files on your computer

plot(T3, E3,xscale = :log,yscale = :log,linewidth = 5,label = "Julia GL (FractionalDiffEq.jl)", xlabel="Time (sc, Log)", ylabel="Error: 2-norm (Log)")

gr()
plot(T5, E5, xscale = :log, yscale = :log,linewidth = 5,label = "Julia NonLinearAlg (FractionalDiffEq.jl)", xlabel="Time (sc, Log)", ylabel="Error: 2-norm (Log)")
plot!(Mdata[!, 3], Mdata[!, 6], linewidth = 5,label = "Matlab PI-EX (Garrappa)", legend = false)
plot!(T4, E4,linewidth = 5, label = "Julia PI-EX (FractionalDiffEq.jl)")
plot!(Mdata[!, 1], Mdata[!, 4], linewidth = 5, label = "Matlab PI-PC (Garrappa)")
plot!(T1, E1, linewidth = 5, markersize = 5, label = "Julia PI-PC (FdeSolver.jl)", shape = :square,
    linecolor = :black, markercolor = :white, thickness_scaling = 1)
gr(size=(1200,1000), xtickfontsize=20, ytickfontsize=20, xguidefontsize=20, yguidefontsize=20, legendfontsize=20, dpi=200, grid=(:xy, :gray, :solid, 1, .4));
plot!(Mdata[!, 2], Mdata[!, 5], linewidth = 5, label = "Matlab P-IM (Garrappa)")
plot!(T2, E2,linewidth = 5, label = "Julia P-IM (FdeSolver.jl)")
plot!(T6, E6,linewidth = 5, label = "Julia FLMMBDF (FractionalDiffEq.jl)")
plot!(T7, E7,linewidth = 5, label = "Julia FLMMNewtonGregory (FractionalDiffEq.jl)")
plot!(T8, E8,linewidth = 5, label = "Julia FLMMTrap (FractionalDiffEq.jl)")
plotd= plot!(T9, E9,linewidth = 5, label = "Julia PECE (FractionalDiffEq.jl)", legend = false)


# gr(size=(1200,1000), xtickfontsize=20, ytickfontsize=20, xguidefontsize=20, yguidefontsize=20, legendfontsize=20, dpi=200, grid=(:xy, :gray, :solid, 1, .4));
plot(T1, E1, xscale = :log, yscale = :log, linewidth = 5, markersize = 5,
     label = "Julia PI-PC (FdeSolver.jl)", shape = :rect, xlabel="Time (sc, Log)", ylabel="Error: 2-norm (Log)",
    color = :black, thickness_scaling = 1)
plot!(T2, E2,linewidth = 5, markersize = 5,label = "Julia P-IM (FdeSolver.jl)", shape = :circle, color = :black)
plot!(Mdata[!, 1], Mdata[!, 4], linewidth = 5, markersize = 5,label = "Matlab PI-PC (Garrappa)", shape = :rect, color = :red)
plotd1=plot!(Mdata[!, 2], Mdata[!, 5], linewidth = 5, markersize = 5,label = "Matlab P-IM (Garrappa)", shape = :circle, color = :red)
savefig(plotd1,"file1.png")

plot!(T5, E5, xscale = :log, yscale = :log, linewidth = 5, label = "Julia NonLinearAlg (FractionalDiffEq.jl)", shape = :star5)
# plot!(Mdata[!, 3], Mdata[!, 6], linewidth = 5,label = "Matlab PI-EX (Garrappa)", legend = false)
plot!(T9, E9,linewidth = 5,  markersize = 5, label = "Julia PECE (FractionalDiffEq.jl)", shape = :diamond)
plot!(T4, E4,linewidth = 5, markersize = 5, label = "Julia PI-EX (FractionalDiffEq.jl)", shape = :hexagon)
plot!(T6, E6,linewidth = 5,markersize = 5,  label = "Julia FLMMBDF (FractionalDiffEq.jl)", shape = :xcross)
plot!(T7, E7,linewidth = 5,markersize = 5,  label = "Julia FLMMNewtonGregory (FractionalDiffEq.jl)", shape = :utriangle)
plot!(T8, E8,linewidth = 5, markersize = 5, label = "Julia FLMMTrap (FractionalDiffEq.jl)", shape = :pentagon)
plotd= plot!(T3, E3, linewidth = 5, markersize = 5, label = "Julia GL (FractionalDiffEq.jl)", shape = :dtriangle, legend_position= :outerbottomright)
# , legend = false
savefig(plotd,"file.png")
