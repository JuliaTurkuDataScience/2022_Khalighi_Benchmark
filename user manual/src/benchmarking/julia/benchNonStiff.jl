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

##scifracx
F2(y, par, t) = (40320 ./ gamma(9 - 0.5) .* t .^ (8 - 0.5) .- 3 .* gamma(5 + 0.5 / 2)
           ./ gamma(5 - 0.5 / 2) .* t .^ (4 - 0.5 / 2) .+ 9/4 * gamma(0.5 + 1) .+
           (3 / 2 .* t .^ (0.5 / 2) .- t .^ 4) .^ 3 .- y .^ (3 / 2))

prob = SingleTermFODEProblem(F2, β, y0, (0, 1));

#Analytical solution
Exact(t) = t.^8 - 3 * t .^ (4 + β / 2) + 9 / 4 * t.^β
## Check the results after the second run
E1 = Float64[];T1 = Float64[];E2 = Float64[];T2 = Float64[]
E3 = Float64[];T3 = Float64[];E4 = Float64[];T4 = Float64[]
E5 = Float64[];T5 = Float64[];E6 = Float64[];T6 = Float64[];
h = Float64[]

for n in range(3, 8)
    println("n: $n")
    h = 2.0^-n # step size
    t1= @benchmark FDEsolver(F, $(tSpan), $(y0), $(β), $(par) , h=$(h)) seconds=1
    t2= @benchmark FDEsolver(F, $(tSpan), $(y0), $(β), $(par), JF = JF, h=$(h)) seconds=1
    t4= @benchmark solve($(prob), $(h), $(PIEX())) seconds=1
    t5= @benchmark solve($(prob), $(h), $(GL())) seconds=1
    t6= @benchmark solve($(prob), $(h), $(Euler())) seconds=1

    tt1, y1 = FDEsolver(F, tSpan, y0, β, par, h=h)
    tt2, y2= FDEsolver(F, tSpan, y0, β, par, JF = JF, h=h)
    y4 =  solve(prob, h, PIEX());
    y5 =  solve(prob, h, GL());
    y6 =  solve(prob, h, Euler());

    ery1=norm(y1 - map(Exact, tt1), 2)
    ery2=norm(y2 - map(Exact, tt2), 2)
    ery4=norm(y4.u - map(Exact, y4.t),2)
    ery5=norm(y5.u - map(Exact, y5.t),2)
    ery6=norm(y6.u - map(Exact, y6.t),2)


    push!(E1, ery1)
    push!(E2, ery2)
    push!(E4, ery4)
    push!(E5, ery5)
    push!(E6, ery6)


    # convert from nano seconds to seconds
    push!(T1, mean(t1).time / 10^9)
    push!(T2, mean(t2).time / 10^9)
    push!(T4, mean(t4).time / 10^9)
    push!(T5, mean(t5).time / 10^9)
    push!(T6, mean(t6).time / 10^9)

    if n>3
      t3 = @benchmark solve($(prob), $(h), PECE()) seconds=1
      y3 = solve(prob, h, PECE());
      ery3=norm(y3.u - map(Exact, y3.t),2)
      push!(E3, ery3)
      push!(T3, mean(t3).time / 10^9)
    end
end

plot(T1, E1, xscale = :log, yscale = :log, label = "J-1", shape = :diamond,
 xlabel="Execution time (sc, Log)", ylabel="Error: 2-norm (Log)",
     thickness_scaling = 1, fc=:transparent,framestyle=:box, color="firebrick3")
 plot!(T2, E2,label = "J-2", shape = :diamond, color="firebrick3")
 plot!(T3, E3,label = "J-PECE", shape = :rtriangle, color="darkorange")
 plot!(T4, E4,label = "J-PIEX", shape = :star5, color="darkorange")
 plot!(T5, E5,label = "J-GL", shape = :square, color="darkorange")
 plot!(T6, E6,label = "J-Euler", shape = :circle, color="darkorange")
 plot!(Mdata[:, 1], Mdata[:, 5],label = "M-1",shape = :rect, color="royalblue3")
 plot!(Mdata[:, 3], Mdata[:, 7], label = "M-2", shape = :rect, color="royalblue3")
 plot!(Mdata[:, 2], Mdata[:, 6], label = "M-3", shape = :rect, color="royalblue3")
 pNonStiff=plot!(Mdata[:, 4], Mdata[:, 8], label = "M-4", shape = :rect, legend_position=:bottomleft, color="royalblue3")

# savefig(pNonStiff,"NonStiff.svg")

#save data
CSV.write(joinpath(data_dir, "data_Julia/NonStiff_E1.csv"),  Tables.table(E1))
CSV.write(joinpath(data_dir, "data_Julia/NonStiff_E2.csv"),  Tables.table(E2))
CSV.write(joinpath(data_dir, "data_Julia/NonStiff_E3.csv"),  Tables.table(E3))
CSV.write(joinpath(data_dir, "data_Julia/NonStiff_E4.csv"),  Tables.table(E4))
CSV.write(joinpath(data_dir, "data_Julia/NonStiff_E5.csv"),  Tables.table(E5))
CSV.write(joinpath(data_dir, "data_Julia/NonStiff_E6.csv"),  Tables.table(E6))
CSV.write(joinpath(data_dir, "data_Julia/NonStiff_T1.csv"),  Tables.table(T1))
CSV.write(joinpath(data_dir, "data_Julia/NonStiff_T2.csv"),  Tables.table(T2))
CSV.write(joinpath(data_dir, "data_Julia/NonStiff_T3.csv"),  Tables.table(T3))
CSV.write(joinpath(data_dir, "data_Julia/NonStiff_T4.csv"),  Tables.table(T4))
CSV.write(joinpath(data_dir, "data_Julia/NonStiff_T5.csv"),  Tables.table(T5))
CSV.write(joinpath(data_dir, "data_Julia/NonStiff_T6.csv"),  Tables.table(T6))
