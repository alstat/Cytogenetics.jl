"""
Checker Functions
"""
function checker(::Type{T}, d::AbstractDataFrame, args::Symbol...) where T <: AbstractModel
    err1 = "args... takes three arguments for the following variables (in order): aberration, cells, doses"
    err2 = "args... should match the corresponding column name in d"
    return length(args) != 3 ? error(err1) : sum([args[i] for i in 1:length(args)] .∈ [names(d)]) != length(args) ? error(err2) : true
end

function checker(::Type{T}, d::AbstractDataFrame, args::Symbol...) where T <: AbstractTest
    err1 = "args... takes two arguments for the following variables (in order): aberration, cells"
    err2 = "args... should match the corresponding column name in d"
    return length(args) != 2 ? error(err1) : sum([args[i] for i in 1:length(args)] .∈ [names(d)]) != length(args) ? error(err2) : true
end