"""
Checker Functions
"""
function checker(::Type{T}, df::DataFrame, args::Symbol...) where T <: AbstractModel
    err1 = "args... takes three arguments for the following variables (in order): aberration, cells, doses"
    err2 = "args... should match the corresponding column name in d"
    return length(args) != 3 ? error(err1) : sum([args[i] for i in 1:length(args)] .∈ [names(df)]) != length(args) ? error(err2) : true
end

function checker(::Type{T}, df::DataFrame, args::Symbol...) where T <: AbstractTest
    err1 = "args... takes two arguments for the following variables (in order): aberration, cells"
    err2 = "args... should match the corresponding column name in d"
    return length(args) != 2 ? error(err1) : sum([args[i] for i in 1:length(args)] .∈ [names(df)]) != length(args) ? error(err2) : true
end

checker(M::LinearQuadratic, df::DataFrame, args::Symbol...) = checker(LinearQuadratic, df, args...)
checker(M::Linear, df::DataFrame, args::Symbol...) = checker(Linear, df, args...)