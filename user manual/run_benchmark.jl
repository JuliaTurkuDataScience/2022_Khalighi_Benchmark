using BenchmarkTools
using FdeSolver, FractionalDiffEq
using Plots, LinearAlgebra, SpecialFunctions
using CSV, DataFrames, Tables

source_dir = joinpath(@__DIR__, "src/benchmarking/julia")
# directory where data is read from and saved into (the "data" directory)
data_dir = joinpath(@__DIR__, "data/raw")

# run nonstiff_benchmark
Mdata = CSV.read(joinpath(data_dir, "data_matlab/BenchNonStiff.csv"), DataFrame, header=0)
include(joinpath(source_dir, "benchNonStiff.jl"))

# run stiff_benchmark
Mdata = Matrix(CSV.read(joinpath(data_dir, "data_matlab/BenchStiff.csv"), DataFrame, header=0))
include(joinpath(source_dir, "benchStiff.jl"))

# run harmonic_benchmark
Mdata = Matrix(CSV.read(joinpath(data_dir, "data_matlab/BenchHarmonic.csv"), DataFrame, header = 0))
include(joinpath(source_dir, "benchHarmonic.jl"))

# run sir_benchmark
# Benchmark from Matlab
Mdata = Matrix(CSV.read(joinpath(data_dir, "data_matlab/BenchSIR.csv"), DataFrame, header = 0))
# Exact from Matlab
M_ExactSIR = Matrix(CSV.read(joinpath(data_dir, "data_matlab/M_ExactSIR.csv"), DataFrame, header = 0))
include(joinpath(source_dir, "benchSIR.jl"))

# run lotka_volterra_benchmark
# Benchmark from Matlab
Mdata = Matrix(CSV.read(joinpath(data_dir, "data_matlab/BenchLV.csv"), DataFrame, header = 0))
# Exact from Matlab
M_ExactLV3 = Matrix(CSV.read(joinpath(data_dir, "data_matlab/M_Exact_LV3.csv"), DataFrame, header = 0))
include(joinpath(source_dir, "bench3LV.jl"))

# run random_params_benchmark
M_Ex1 = CSV.read(joinpath(data_dir, "data_matlab/RndEx1.csv"), DataFrame, header = 1)
M_Ex2 = CSV.read(joinpath(data_dir, "data_matlab/RndEx2.csv"), DataFrame, header = 1)
M_Ex3 = CSV.read(joinpath(data_dir, "data_matlab/RndEx3.csv"), DataFrame, header = 1)
M_Ex4 = CSV.read(joinpath(data_dir, "data_matlab/RndEx4.csv"), DataFrame, header = 1)
include(joinpath(source_dir, "Random.jl"))
