## inputs
tSpan = [0, 5]     # [intial time, final time]
y0 = 1             # intial value
β = 0.8            # order of the derivative

λ = -10
par = λ
F(t, y, par)= par * y
JF(t, y, par) = par

##scifracx
F2(y, par, t) = -10 * y

prob = SingleTermFODEProblem(F2, β, y0, (0, 5));

#exact solution: mittag-leffler
Exact(t) = mittleff(β, λ * t .^ β)

# Benchmarking
E1 = Float64[];T1 = Float64[];E2 = Float64[];T2 = Float64[]
E3 = Float64[];T3 = Float64[];E4 = Float64[];T4 = Float64[]
E5 = Float64[];T5 = Float64[];E6 = Float64[];T6 = Float64[];
h = Float64[]


for n in range(3, 8)
    println("n: $n")# to print out the current step of runing
    h = 2.0^-n #stepsize of computting
        #computing the time
    t1= @benchmark FDEsolver(F, $(tSpan), $(y0), $(β), $(par) , h=$(h), nc=4) seconds=1
    t2= @benchmark FDEsolver(F, $(tSpan), $(y0), $(β), $(par), JF = JF, h=$(h)) seconds=1
    t3= @benchmark solve($(prob), $(h), $(PECE())); seconds=1
    t4 = @benchmark solve($(prob), $(h), PIEX()); seconds=1
    t5= @benchmark solve($(prob), $(h), $(GL())); seconds=1
    t6= @benchmark solve($(prob), $(h), $(Euler())); seconds=1

    # convert from nano seconds to seconds
    push!(T1, mean(t1).time / 10^9)
    push!(T2, mean(t2).time / 10^9)
    push!(T3, mean(t3).time / 10^9)
    push!(T4, mean(t4).time / 10^9)
    push!(T5, mean(t5).time / 10^9)
    push!(T6, mean(t6).time / 10^9)

    #computing the error
    tt1, y1 = FDEsolver(F, tSpan, y0, β, par , h=h, nc=4)
    _, y2 = FDEsolver(F, tSpan, y0, β, par, JF = JF, h=h)
    y3 =  solve(prob, h, PECE());
    y4 =  solve(prob, h, PIEX());
    y5 =  solve(prob, h, GL());
    y6 =  solve(prob, h, Euler());

    ery1=norm(y1 - map(Exact, tt1), 2)
    ery2=norm(y2 - map(Exact, tt1), 2)
    ery3=norm(y3.u - map(Exact, y3.t),2)
    ery4=norm(y4.u - map(Exact, y4.t),2)
    ery5=norm(y5.u - map(Exact, y5.t),2)
    ery6=norm(y6.u - map(Exact, y6.t),2)

    push!(E1, ery1)
    push!(E2, ery2)
    push!(E3, ery3)
    push!(E4, ery4)
    push!(E5, ery5)
    push!(E6, ery6)

end

## plotting
# plot Matlab and FdeSolver outputs
plot(T1, E1, xscale = :log, yscale = :log,
     label = "J-PC", shape = :circle, xlabel="Execution time (sc, Log)", ylabel="Error: 2-norm (Log)",
     thickness_scaling = 1, fc=:transparent,framestyle=:box, color="blue")
 plot!(T2, E2,label = "J-NR", shape = :rect, color = :blue)
 plot!(T3, E3,label = "J-PECE", shape = :rtriangle, color="darkorange")
 plot!(T4, E4,label = "J-PIEX", shape = :star5, color="darkorange")
 plot!(T5, E5,label = "J-GL", shape = :square, color="darkorange")
 plot!(T6, E6,label = "J-Euler", shape = :circle, color="darkorange")
 plot!(Mdata[:, 1], Mdata[:, 5], label = "M-PI-EX",shape = :rtriangle, color = :red)
 plot!(Mdata[:, 2], Mdata[:, 6], label = "M-PI-PC", shape = :circle, color = :red)
 plot!(Mdata[:, 3], Mdata[:, 7], label = "M-PI-IM1", shape = :diamond, color = :red)
 pStiff1=plot!(Mdata[:, 4], Mdata[:, 8],label = "M-PI-IM2", shape = :rect, color = :red)

# savefig(pStiff1,"Stiff1.svg")

plot(T2, E2, linewidth = 2, markersize = 5,
     label = "J-NR", shape = :rect, xlabel="Execution time (sc)", ylabel="Error: 2-norm",
     thickness_scaling = 1,legend_position= :right, c=:blue,fc=:transparent,framestyle=:box, mc=:white)
 pStiff2=plot!(Mdata[:, 4], Mdata[:, 8], linewidth = 2, markersize = 5,label = "M-PI-IM2", shape = :rect, color = :red, mc=:white)

# savefig(pStiff2,"Stiff2.svg")
plot(T1[2:end], E1[2:end], xscale = :log, yscale = :log, label = "J-1", shape = :diamond,
 xlabel="Execution time (sc, Log)", ylabel="Error: 2-norm (Log)",
     thickness_scaling = 1, fc=:transparent,framestyle=:box, color="firebrick3")
 plot!(T2, E2,label = "J-2", shape = :diamond, color="firebrick3")
 plot!(T3[2:end], E3[2:end],label = "J-PECE", shape = :rtriangle, color="darkorange")
 plot!(T4, E4,label = "J-PIEX", shape = :star5, color="darkorange")
 plot!(T5[2:end], E5[2:end],label = "J-GL", shape = :square, color="darkorange")
 plot!(T6[2:end], E6[2:end],label = "J-Euler", shape = :circle, color="darkorange")
 plot!(Mdata[2:end, 1], Mdata[2:end, 5],label = "M-1",shape = :rect, color="royalblue3")
 plot!(Mdata[:, 3], Mdata[:, 7], label = "M-2", shape = :rect, color="royalblue3")
 plot!(Mdata[2:end, 2], Mdata[2:end, 6], label = "M-3", shape = :rect, color="royalblue3")
 pStiff3=plot!(Mdata[:, 4], Mdata[:, 8], label = "M-4", shape = :rect, legend_position=:bottomleft, color="royalblue3")

# savefig(pStiff3,"Stiff3.svg")

#save data
CSV.write(joinpath(data_dir, "data_Julia/Stiff_E1.csv"),  Tables.table(E1))
CSV.write(joinpath(data_dir, "data_Julia/Stiff_E2.csv"),  Tables.table(E2))
CSV.write(joinpath(data_dir, "data_Julia/Stiff_E3.csv"),  Tables.table(E3))
CSV.write(joinpath(data_dir, "data_Julia/Stiff_E4.csv"),  Tables.table(E4))
CSV.write(joinpath(data_dir, "data_Julia/Stiff_E5.csv"),  Tables.table(E5))
CSV.write(joinpath(data_dir, "data_Julia/Stiff_E6.csv"),  Tables.table(E6))
CSV.write(joinpath(data_dir, "data_Julia/Stiff_T1.csv"),  Tables.table(T1))
CSV.write(joinpath(data_dir, "data_Julia/Stiff_T2.csv"),  Tables.table(T2))
CSV.write(joinpath(data_dir, "data_Julia/Stiff_T3.csv"),  Tables.table(T3))
CSV.write(joinpath(data_dir, "data_Julia/Stiff_T4.csv"),  Tables.table(T4))
CSV.write(joinpath(data_dir, "data_Julia/Stiff_T5.csv"),  Tables.table(T5))
CSV.write(joinpath(data_dir, "data_Julia/Stiff_T6.csv"),  Tables.table(T6))
