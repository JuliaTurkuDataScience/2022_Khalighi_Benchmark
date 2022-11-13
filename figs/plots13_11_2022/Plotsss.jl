using Plots, CSV, DataFrames
using StatsPlots
theme(:ggplot2)
# Data from Matlab
M_Ex1 = CSV.read("RndEx1.csv", DataFrame, header = 1)
M_Ex2 = CSV.read("RndEx2.csv", DataFrame, header = 1)
M_Ex3 = CSV.read("RndEx3.csv", DataFrame, header = 1)
M_Ex4 = CSV.read("RndEx4.csv", DataFrame, header = 1)

M_NonStiff = CSV.read("BenchNonStiff.csv", DataFrame, header = 0)
M_Stiff = CSV.read("BenchStiff.csv", DataFrame, header = 0)
M_Harmonic = CSV.read("BenchHarmonic.csv", DataFrame, header = 0)
M_SIR = CSV.read("BenchSIR.csv", DataFrame, header = 0)
M_LV = CSV.read("BenchLV.csv", DataFrame, header = 0)

# Data from Julia
J_Nonstiff_E1 = CSV.read("NonStiff_E1.csv", DataFrame, header = 1)
J_Nonstiff_E2 = CSV.read("NonStiff_E2.csv", DataFrame, header = 1)
J_Nonstiff_T1 = CSV.read("NonStiff_T1.csv", DataFrame, header = 1)
J_Nonstiff_T2 = CSV.read("NonStiff_T2.csv", DataFrame, header = 1)

J_stiff_E1 = CSV.read("Stiff_E1.csv", DataFrame, header = 1)
J_stiff_E2 = CSV.read("Stiff_E2.csv", DataFrame, header = 1)
J_stiff_T1 = CSV.read("Stiff_T1.csv", DataFrame, header = 1)
J_stiff_T2 = CSV.read("Stiff_T2.csv", DataFrame, header = 1)

J_Harmonic_E1 = CSV.read("Harmonic_E1.csv", DataFrame, header = 1)
J_Harmonic_E2 = CSV.read("Harmonic_E2.csv", DataFrame, header = 1)
J_Harmonic_T1 = CSV.read("Harmonic_T1.csv", DataFrame, header = 1)
J_Harmonic_T2 = CSV.read("Harmonic_T2.csv", DataFrame, header = 1)

J_LV_E1 = CSV.read("LV_E1.csv", DataFrame, header = 1)
J_LV_E2 = CSV.read("LV_E2.csv", DataFrame, header = 1)
J_LV_T1 = CSV.read("LV_T1.csv", DataFrame, header = 1)
J_LV_T2 = CSV.read("LV_T2.csv", DataFrame, header = 1)
DynLV = CSV.read("DynLV.csv", DataFrame, header = 1)

J_SIR_E1 = CSV.read("SIR_E1.csv", DataFrame, header = 1)
J_SIR_E2 = CSV.read("SIR_E2.csv", DataFrame, header = 1)
J_SIR_T1 = CSV.read("SIR_T1.csv", DataFrame, header = 1)
J_SIR_T2 = CSV.read("SIR_T2.csv", DataFrame, header = 1)
# J_SIR_E3 = CSV.read("SIR_E3.csv", DataFrame, header = 1)
J_SIR_E4 = CSV.read("SIR_E4.csv", DataFrame, header = 1)
# J_SIR_T3 = CSV.read("SIR_T3.csv", DataFrame, header = 1)
J_SIR_T4 = CSV.read("SIR_T4.csv", DataFrame, header = 1)
J_SIR_E5 = CSV.read("SIR_E5.csv", DataFrame, header = 1)
J_SIR_E6 = CSV.read("SIR_E6.csv", DataFrame, header = 1)
J_SIR_T5 = CSV.read("SIR_T5.csv", DataFrame, header = 1)
J_SIR_T6 = CSV.read("SIR_T6.csv", DataFrame, header = 1)
J_SIR_E7 = CSV.read("SIR_E7.csv", DataFrame, header = 1)
J_SIR_E8 = CSV.read("SIR_E8.csv", DataFrame, header = 1)
J_SIR_E9 = CSV.read("SIR_E9.csv", DataFrame, header = 1)
J_SIR_T7 = CSV.read("SIR_T7.csv", DataFrame, header = 1)
J_SIR_T8 = CSV.read("SIR_T8.csv", DataFrame, header = 1)
J_SIR_T9 = CSV.read("SIR_T9.csv", DataFrame, header = 1)

J_tRnd1=CSV.read("tRnd1.csv", DataFrame, header = 1)
J_tRnd2=CSV.read("tRnd2.csv", DataFrame, header = 1)
J_ErrRnd1=CSV.read("ErrRnd1.csv", DataFrame, header = 1)
J_ErrRnd2=CSV.read("ErrRnd2.csv", DataFrame, header = 1)


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

scatter(Vector(J_tRnd1[:,1]), Vector(J_ErrRnd1[:,1]), xscale = :log, yscale = :log, linewidth = 3, markersize = 5,
     label = "J-PC", shape = :circle, xlabel="Execution time (sc, Log)", ylabel="Error: 2-norm (Log)",
     thickness_scaling = 1,legend_position= :bottomleft, fc=:transparent,framestyle=:box)
     scatter!(Vector(J_tRnd2[:,1]), Vector(J_ErrRnd2[:,1]),linewidth = 3, markersize = 5,label = "J-NR", shape = :rect)

    Mt1=vcat(M_Ex1.Bench1_1,M_Ex2.Bench2_1,M_Ex3.Bench3_1,M_Ex4.Bench4_1)
    Merr1=vcat(M_Ex1.Bench1_5,M_Ex2.Bench2_5,M_Ex3.Bench3_5,M_Ex4.Bench4_5)

    Mt2=vcat(M_Ex1.Bench1_2,M_Ex2.Bench2_2,M_Ex3.Bench3_2,M_Ex4.Bench4_2)
    Merr2=vcat(M_Ex1.Bench1_6,M_Ex2.Bench2_6,M_Ex3.Bench3_6,M_Ex4.Bench4_6)

    Mt3=vcat(M_Ex1.Bench1_3,M_Ex2.Bench2_3,M_Ex3.Bench3_3,M_Ex4.Bench4_3)
    Merr3=vcat(M_Ex1.Bench1_7,M_Ex2.Bench2_7,M_Ex3.Bench3_7,M_Ex4.Bench4_7)

    Mt4=vcat(M_Ex1.Bench1_4,M_Ex2.Bench2_4,M_Ex3.Bench3_4,M_Ex4.Bench4_4)
    Merr4=vcat(M_Ex1.Bench1_8,M_Ex2.Bench2_8,M_Ex3.Bench3_8,M_Ex4.Bench4_8)

    scatter!(Mt1, Merr1, linewidth = 3, markersize = 5,label = "M-PI-EX",shape = :rtriangle)
    scatter!(Mt3, Merr3, linewidth = 3, markersize = 5,label = "M-PI-IM1", shape = :diamond)
    scatter!(Mt2, Merr2, linewidth = 3, markersize = 5,label = "M-PI-PC", shape = :circle)
    p7=scatter!(Mt4, Merr4, linewidth = 3, markersize = 5,label = "M-PI-IM2", shape = :rect,
    title = "(a)", titleloc = :left, titlefont = font(10))

X = ["J-PC", "J-NR","M-PI-EX","M-PI-IM1","M-PI-PC","M-PI-IM2"]
    Y=[Vector(J_ErrRnd1[:,1]),Vector(J_ErrRnd2[:,1]),Merr1,Merr2,Merr3,Merr4]
    X2 = [fill(x,length(y)) for (x,y) in zip(X,Y)]
    df = DataFrame(X = X2, Y = Y)
    p8 = @df df boxplot(:X, :Y, c=:black, fillcolor=:white, legend=false,
    title = "(b)", titleloc = :left, titlefont = font(10),
    yscale=:log, ylabel="Error: 2-norm (Log)")

X = ["J-PC", "J-NR","M-PI-EX","M-PI-IM1","M-PI-PC","M-PI-IM2"]
        Y=[Vector(J_tRnd1[:,1]),Vector(J_tRnd2[:,1]),Mt1,Mt2,Mt3,Mt4]
        X2 = [fill(x,length(y)) for (x,y) in zip(X,Y)]
        df = DataFrame(X = X2, Y = Y)
        p9 = @df df boxplot(:X, :Y, c=:black, fillcolor=:white, legend=false,
        title = "(c)", titleloc = :left, titlefont = font(10),
        yscale=:log, ylabel="Execution time (sc, Log)")

l = @layout [b{.5w} grid(2,1)]
PltRnd=plot(p7, p8, p9, layout = l,size = (800, 500))

savefig(Plt1D,"Plt1D.svg")
savefig(PltMD,"PltMD.svg")
savefig(PltRnd,"PltRnd.svg")
savefig(Plt1D,"Plt1D.png")
savefig(PltMD,"PltMD.png")
savefig(PltRnd,"PltRnd.png")
