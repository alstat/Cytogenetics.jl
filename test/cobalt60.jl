include("src/Cytogenetic.jl")

using Cytogenetic
using DataFrames

my_data = readtable(joinpath(homedir(), "Desktop", "cobalt.csv"));
my_data

utest(my_data, :aberr, :cell; celldist = [5, 10])