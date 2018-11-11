include("src/Cytogenetic.jl")

using Cytogenetic
using DataFrames
using CSV

data = DataFrame(CSV.File(joinpath(homedir(), "Documents", "Cobalt60.csv")));
data

x = test(AbstractUTest, data, :aberr, :cell; celldist = [4, 9])

fit(LinearQuadratic, data, :aberr, :cell, :doses)
fit(LinearQuadratic(true), data, :aberr, :cell, :doses)
fit(LinearQuadratic(overdispersed = true), data, :aberr, :cell, :doses)

fit(Linear, data, :aberr, :cell, :doses)
fit(Linear(overdispersed = true), data, :aberr, :cell, :doses)
fit(Linear(true), data, :aberr, :cell, :doses)