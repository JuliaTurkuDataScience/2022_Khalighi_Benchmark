# reference for model
# https://doi.org/10.1016/j.chaos.2020.109846
# https://doi.org/10.1016/j.chaos.2021.110652
# https://doi.org/10.3390/axioms10030135

using Optim, StatsBase
using FdeSolver
using Plots, StatsPlots, StatsPlots.PlotMeasures
using SpecialFunctions
using CSV, HTTP, DataFrames, Dates

source_dir = joinpath(@__DIR__, "src/covid_fitting")
output_dir = joinpath(@__DIR__, "results/covid_fitting")

# dataset of Covid from CSSE
repo = HTTP.get("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
dataset_CC = CSV.read(repo.body, DataFrame) # all data of confirmed

# run models
include(joinpath(source_dir, "Portugal_model_SEIPAHRF.jl")) # Portugal
include(joinpath(source_dir, "Spain_model_SEIPAHRF.jl"))    # Spain

# make plot
P = plot(plSpain, plPortugal,
    layout=grid(2, 1), size=(700, 650))

savefig(P, joinpath(output_dir, "CovidSpnPrt.svg"))
