using LinearAlgebra
using BenchmarkTools
using FdeSolver
using FractionalDiffEq, Plots
using SpecialFunctions
using CSV, DataFrames

## insert data
#it should be based on the directory of CSV files on your computer
push!(LOAD_PATH, "./FDEsolver")
Mdata = Matrix(CSV.read("BenchStiff.csv", DataFrame, header = 0)) #Benchmark from Matlab

## inputs
tSpan = [0, 5]     # [intial time, final time]
y0 = 1             # intial value
α = 0.8            # order of the derivative

λ = -10
par = λ
F(t, y, par)= par * y
JF(t, y, par) = par

t, Yex= FDEsolver(F, tSpan, y0, α, par, JF = JF, h=2^-10, tol=1e-12) # Solution with a fine step size

# Benchmarking
E1 = Float64[];T1 = Float64[];E2 = Float64[];T2 = Float64[]
h = Float64[]


for n in range(3, 8)
    println("n: $n")# to print out the current step of runing
    h = 2.0^-n #stepsize of computting
        #computting the time
    t1= @benchmark FDEsolver(F, $(tSpan), $(y0), $(α), $(par) , h=$(h), nc=4, tol=1e-6) seconds=1
    t2= @benchmark FDEsolver(F, $(tSpan), $(y0), $(α), $(par), JF = JF, h=$(h), tol=1e-8) seconds=1

    # convert from nano seconds to seconds
    push!(T1, minimum(t1).time / 10^9)
    push!(T2, minimum(t2).time / 10^9)
    #computting the error
    _, y1 = FDEsolver(F, tSpan, y0, α, par , h=h, nc=4, tol=1e-6)
    _, y2 = FDEsolver(F, tSpan, y0, α, par, JF = JF, h=h,tol=1e-8)

    ery1=norm(y1 .- Yex[1:2^(10-n):end,:],2)
    ery2=norm(y2 .- Yex[1:2^(10-n):end,:],2)

    push!(E1, ery1)
    push!(E2, ery2)

end

## plotting
# plot Matlab and FdeSolver outputs
plot(T1, E1, xscale = :log, yscale = :log, linewidth = 2, markersize = 5,
     label = "Julia PC (FdeSolver.jl)", shape = :circle, xlabel="Time (sc, Log)", ylabel="Error: 2-norm (Log)",
     thickness_scaling = 1,legend_position= :right, c=:blue,fc=:transparent,framestyle=:box, mc=:white)
plot!(T2, E2,linewidth = 2, markersize = 5,label = "Julia NR (FdeSolver.jl)", shape = :rect, color = :blue, mc=:white)
plot!(Mdata[:, 1], Mdata[:, 5], linewidth = 2, markersize = 5,label = "Matlab PI-EX (Garrappa)",shape = :rtriangle, color = :red, mc=:white)
plot!(Mdata[:, 2], Mdata[:, 6], linewidth = 2, markersize = 5,label = "Matlab PI-PC (Garrappa)", shape = :circle, color = :red, mc=:white)
plot!(Mdata[:, 3], Mdata[:, 7], linewidth = 2, markersize = 5,label = "Matlab PI-IM1 (Garrappa)", shape = :diamond, color = :red, mc=:white)
pStiff1=plot!(Mdata[:, 4], Mdata[:, 8], linewidth = 2, markersize = 5,label = "Matlab PI-IM2 (Garrappa)", shape = :rect, color = :red, mc=:white)



savefig(pStiff1,"Stiff1.png")
