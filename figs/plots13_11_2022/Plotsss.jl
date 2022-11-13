using Plots, CSV, DataFrames
using StatsPlots
theme(:ggplot2)

# Data from Matlab
matlab_dir = "data_matlab"

M_NonStiff = CSV.read(joinpath(matlab_dir, "BenchNonStiff.csv"), DataFrame, header = 0)
M_Stiff = CSV.read(joinpath(matlab_dir, "BenchStiff.csv"), DataFrame, header = 0)
M_Harmonic = CSV.read(joinpath(matlab_dir, "BenchHarmonic.csv"), DataFrame, header = 0)
M_SIR = CSV.read(joinpath(matlab_dir, "BenchSIR.csv"), DataFrame, header = 0)
M_LV = CSV.read(joinpath(matlab_dir, "BenchLV.csv"), DataFrame, header = 0)

# Data from Julia
julia_dir = "data_Julia"

J_Nonstiff_E1 = CSV.read(joinpath(julia_dir, "NonStiff_E1.csv"), DataFrame, header = 1)
J_Nonstiff_E2 = CSV.read(joinpath(julia_dir, "NonStiff_E2.csv"), DataFrame, header = 1)
J_Nonstiff_T1 = CSV.read(joinpath(julia_dir, "NonStiff_T1.csv"), DataFrame, header = 1)
J_Nonstiff_T2 = CSV.read(joinpath(julia_dir, "NonStiff_T2.csv"), DataFrame, header = 1)

J_Nonstiff = innerjoin(J_Nonstiff_E1, J_Nonstiff_E2, )

J_stiff_E1 = CSV.read(joinpath(julia_dir, "Stiff_E1.csv"), DataFrame, header = 1)
J_stiff_E2 = CSV.read(joinpath(julia_dir, "Stiff_E2.csv"), DataFrame, header = 1)
J_stiff_T1 = CSV.read(joinpath(julia_dir, "Stiff_T1.csv"), DataFrame, header = 1)
J_stiff_T2 = CSV.read(joinpath(julia_dir, "Stiff_T2.csv"), DataFrame, header = 1)

J_Harmonic_E1 = CSV.read(joinpath(julia_dir, "Harmonic_E1.csv"), DataFrame, header = 1)
J_Harmonic_E2 = CSV.read(joinpath(julia_dir, "Harmonic_E2.csv"), DataFrame, header = 1)
J_Harmonic_T1 = CSV.read(joinpath(julia_dir, "Harmonic_T1.csv"), DataFrame, header = 1)
J_Harmonic_T2 = CSV.read(joinpath(julia_dir, "Harmonic_T2.csv"), DataFrame, header = 1)

J_LV_E1 = CSV.read(joinpath(julia_dir, "LV_E1.csv"), DataFrame, header = 1)
J_LV_E2 = CSV.read(joinpath(julia_dir, "LV_E2.csv"), DataFrame, header = 1)
J_LV_T1 = CSV.read(joinpath(julia_dir, "LV_T1.csv"), DataFrame, header = 1)
J_LV_T2 = CSV.read(joinpath(julia_dir, "LV_T2.csv"), DataFrame, header = 1)
DynLV = CSV.read(joinpath(julia_dir, "DynLV.csv"), DataFrame, header = 1)

J_SIR_E1 = CSV.read(joinpath(julia_dir, "SIR_E1.csv"), DataFrame, header = 1)
J_SIR_E2 = CSV.read(joinpath(julia_dir, "SIR_E2.csv"), DataFrame, header = 1)
J_SIR_T1 = CSV.read(joinpath(julia_dir, "SIR_T1.csv"), DataFrame, header = 1)
J_SIR_T2 = CSV.read(joinpath(julia_dir, "SIR_T2.csv"), DataFrame, header = 1)
# J_SIR_E3 = CSV.read(joinpath(julia_dir,"SIR_E3.csv"), DataFrame, header = 1)
J_SIR_E4 = CSV.read(joinpath(julia_dir,"SIR_E4.csv"), DataFrame, header = 1)
# J_SIR_T3 = CSV.read(joinpath(julia_dir,"SIR_T3.csv"), DataFrame, header = 1)
J_SIR_T4 = CSV.read(joinpath(julia_dir, "SIR_T4.csv"), DataFrame, header = 1)
J_SIR_E5 = CSV.read(joinpath(julia_dir, "SIR_E5.csv"), DataFrame, header = 1)
J_SIR_E6 = CSV.read(joinpath(julia_dir, "SIR_E6.csv"), DataFrame, header = 1)
J_SIR_T5 = CSV.read(joinpath(julia_dir, "SIR_T5.csv"), DataFrame, header = 1)
J_SIR_T6 = CSV.read(joinpath(julia_dir, "SIR_T6.csv"), DataFrame, header = 1)
J_SIR_E7 = CSV.read(joinpath(julia_dir, "SIR_E7.csv"), DataFrame, header = 1)
J_SIR_E8 = CSV.read(joinpath(julia_dir, "SIR_E8.csv"), DataFrame, header = 1)
J_SIR_E9 = CSV.read(joinpath(julia_dir, "SIR_E9.csv"), DataFrame, header = 1)
J_SIR_T7 = CSV.read(joinpath(julia_dir, "SIR_T7.csv"), DataFrame, header = 1)
J_SIR_T8 = CSV.read(joinpath(julia_dir, "SIR_T8.csv"), DataFrame, header = 1)
J_SIR_T9 = CSV.read(joinpath(julia_dir, "SIR_T9.csv"), DataFrame, header = 1)

## plot Examples

plot(J_Nonstiff_T1[:,1], J_Nonstiff_E1[:,1], xscale = :log, yscale = :log,
        legend_position=:bottomleft,
     label = "J-PC", shape = :circle, thickness_scaling = 1, framestyle=:box)
 plot!(J_Nonstiff_T2[:,1], J_Nonstiff_E2[:,1],label = "J-NR", shape = :rect)
 plot!(M_NonStiff[:, 1], M_NonStiff[:, 5],label = "M-PI-EX",shape = :rtriangle)
 plot!(M_NonStiff[:, 3], M_NonStiff[:, 7], label = "M-PI-IM1", shape = :diamond)
 plot!(M_NonStiff[:, 2], M_NonStiff[:, 6],label = "M-PI-PC", shape = :circle)
 p1=plot!(M_NonStiff[:, 4], M_NonStiff[:, 8],label = "M-PI-IM2", shape = :rect,
    title = "(a)", titleloc = :left, titlefont = font(10),legend=:false)

plot(J_stiff_T1[2:end,1], J_stiff_E1[2:end,1], xscale = :log, yscale = :log,
         legend_position=:bottomleft,
     label = "J-PC", shape = :circle, thickness_scaling = 1, framestyle=:box)
 plot!(J_stiff_T2[:,1], J_stiff_E2[:,1],label = "J-NR", shape = :rect)
 plot!(M_Stiff[2:end, 1], M_Stiff[2:end, 5], label = "M-PI-EX",shape = :rtriangle)
 plot!(M_Stiff[:, 3], M_Stiff[:, 7], label = "M-PI-IM1", shape = :diamond)
 plot!(M_Stiff[2:end, 2], M_Stiff[2:end, 6], label = "M-PI-PC", shape = :circle)
 p2=plot!(M_Stiff[:, 4], M_Stiff[:, 8], label = "M-PI-IM2", shape = :rect,legendfontsize=6,
 title = "(b)", titleloc = :left, titlefont = font(10),legendposition=:outerbottom)


plot(J_Harmonic_T1[:,1], J_Harmonic_E1[:,1], xscale = :log, yscale = :log,
         legend_position=:bottomleft,
     label = "J-PC", shape = :circle, thickness_scaling = 1, framestyle=:box)
 plot!(J_Harmonic_T2[:,1], J_Harmonic_E2[:,1],label = "J-NR", shape = :rect)
 plot!(M_Harmonic[:, 1], M_Harmonic[:, 5], label = "M-PI-EX",shape = :rtriangle)
 plot!(M_Harmonic[:, 3], M_Harmonic[:, 7], label = "M-PI-IM1", shape = :diamond)
 plot!(M_Harmonic[:, 2], M_Harmonic[:, 6], label = "M-PI-PC", shape = :circle)
 p3=plot!(M_Harmonic[:, 4], M_Harmonic[:, 8], label = "M-PI-IM2", shape = :rect,
    ylabel="Error: 2-norm (Log)",xlabel="Execution time (sc, Log)",
    title = "(c)", titleloc = :left, titlefont = font(10),legend=:false)


plot(J_SIR_T1[:,1], J_SIR_E1[:,1], xscale = :log, yscale = :log,
         legend_position=:bottomleft,
     label = "J-PC", shape = :circle, thickness_scaling = 1, framestyle=:box)
     plot!(J_SIR_T2[:,1], J_SIR_E2[:,1],label = "J-NR", shape = :rect)
    plot!(M_SIR[:, 1], M_SIR[:, 5], label = "M-PI-EX",shape = :rtriangle)
    plot!(M_SIR[:, 3], M_SIR[:, 7], label = "M-PI-IM1", shape = :diamond)
    plot!(M_SIR[:, 2], M_SIR[:, 6], label = "M-PI-PC", shape = :circle)
    plot!(M_SIR[:, 4], M_SIR[:, 8], label = "M-PI-IM2", shape = :rect,legend=:false)
    plot!(J_SIR_T5[:,1], J_SIR_E5[:,1], xscale = :log, yscale = :log,  label = "J-NonLinearAlg", shape = :star5)
    plot!(J_SIR_T9[:,1], J_SIR_E9[:,1],   label = "J-PECE", shape = :circle)
    plot!(J_SIR_T4[:,1], J_SIR_E4[:,1], label = "J-PI-EX", shape = :hexagon)
    plot!(J_SIR_T6[:,1], J_SIR_E6[:,1],  label = "J-FLMMBDF", shape = :utriangle)
    plot!(J_SIR_T7[:,1], J_SIR_E7[:,1],  label = "J-FLMMNewtonG", shape = :dtriangle)
    p4=plot!(J_SIR_T8[:,1], J_SIR_E8[:,1], label = "J-FLMMTrap", shape = :pentagon,
    ylabel="Error: 2-norm (Log)",xlabel="Execution time (sc, Log)",legendfontsize=6,
    legendposition=:outerbottomright,title = "(a)", titleloc = :left, titlefont = font(10))


plot(J_LV_T1[:,1], J_LV_E1[:,1], xscale = :log, yscale = :log,
         legend_position=:bottomleft,
     label = "J-PC", shape = :circle, thickness_scaling = 1, framestyle=:box)
     plot!(J_LV_T2[:,1], J_LV_E2[:,1],label = "J-NR", shape = :rect)
     plot!(M_LV[:, 1], M_LV[:, 5], label = "M-PI-EX",shape = :rtriangle)
     plot!(M_LV[:, 3], M_LV[:, 7], label = "M-PI-IM1", shape = :diamond)
     plot!(M_LV[:, 2], M_LV[:, 6], label = "M-PI-PC", shape = :circle)
     p5=plot!(M_LV[:, 4], M_LV[:, 8], label = "M-PI-IM2", shape = :rect,
     ylabel="Error: 2-norm (Log)",xlabel="Execution time (sc, Log)",
     title = "(b)", titleloc = :left, titlefont = font(10)   ,legend=:false)

p6=plot(DynLV[:,1],Matrix(DynLV[:,2:4]),xlabel="Time", ylabel="Abundance of species" ,
    thickness_scaling = 1 , framestyle=:box, labels=["X1" "X2" "X3"],
    title = "(c)", titleloc = :left, titlefont = font(10))

# P=plot(p1, p2, layout = (2, 1),legend_position= (.6,.7) , size = (500, 500))
# P=plot(p1, p2, p3, layout = (2,2) , size = (1000, 1000))

# l = @layout [a b; c{.8w} _]
l = @layout [[grid(2,1)] b{.5w}]
# plot(p1, p2, p3,p4, layout = grid(3, 2, widths=[.14 ,0.4, 4,.4]) )
Plt1D=plot(p1, p3, p2, layout = l)


l = @layout [b{.6h}; grid(1,2)]
# plot(p1, p2, p3,p4, layout = grid(3, 2, widths=[.14 ,0.4, 4,.4]) )
PltMD=plot(p4, p5, p6, layout = l,size = (600, 500))


#### plot randoms

random_params_benchmark = CSV.read("data/random_params_benchmark.csv", DataFrame, header = 1)

for (plot_idx, method) in enumerate(unique(random_params_benchmark.Method))
    method_subset = filter(:Method => x -> x == method, random_params_benchmark)
    if plot_idx == 1
        p7 = scatter(method_subset.ExecutionTime,
                    method_subset.Error,
                    scale = :log,
                    label = method,
                    markersize = 3,
                    title = "(a)",
                    xlabel = "Execution time (sc, Log)",
                    ylabel = "Error: 2-norm (Log)",
                    legendposition = :bottomleft)
    else
        scatter!(method_subset.ExecutionTime,
                 method_subset.Error,
                 label = method,
                 markersize = 3)
    end
    display(p)
end

p8 = @df random_params_benchmark boxplot(:Method, :Error,
                                         yscale = :log,
                                         ylabel = "Error: 2-norm (Log)",
                                         c = :black,
                                         fillcolor = :white,
                                         legend = false,
                                         title = "(b)",
                                         titleloc = :left,
                                         titlefont = font(10))

p9 = @df random_params_benchmark boxplot(:Method, :ExecutionTime,
                                         yscale = :log,
                                         ylabel = "Execution time (sc, Log)",
                                         c = :black,
                                         fillcolor = :white,
                                         legend = false,
                                         title = "(c)",
                                         titleloc = :left,
                                         titlefont = font(10))

l3 = @layout [b{.5w} grid(2,1)]
PltRnd = plot(p7, p8, p9,
              layout = l3,
              size = (800, 500))

savefig(PltRnd, "PltRnd.png")
savefig(PltRnd, "PltRnd.svg")

savefig(Plt1D,"Plt1D.svg")
savefig(PltMD,"PltMD.svg")
savefig(Plt1D,"Plt1D.png")
savefig(PltMD,"PltMD.png")
