include("src/Cytogenetic.jl")

using Cytogenetic
using DataFrames
using CSV

data = DataFrame(CSV.File(joinpath(homedir(), "Documents", "Cobalt60.csv")));
data

disptest = test(UTest, data, :aberr, :cell; celldist = [4, 9])

fit(LinearQuadratic, disptest, :aberr, :cell, :doses)
fit(LinearQuadratic(), disptest, :aberr, :cell, :doses)
fit(LinearQuadratic(overdispersed = true), disptest, :aberr, :cell, :doses)

fit(Linear, disptest, :aberr, :cell, :doses)
fit(Linear(), disptest, :aberr, :cell, :doses)
fit(Linear(overdispersed = true), disptest, :aberr, :cell, :doses)