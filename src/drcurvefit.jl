"""
Dose-Response Curve Fitting Function
"""
"""
    fit(::Type{M}, d::DataFrames.AbstractDataFrame, args::Symbol...) where {M <: Model}

fits the model of type ::Type{M} to the data d.
"""
function fit(::Type{M}, d::DataFrames.AbstractDataFrame, args::Symbol...) where {M <: AbstractModel}
    checker(M, d, args...)
        # return filter(d)
    return fieldnames(M)
end