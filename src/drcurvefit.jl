"""
Dose-Response Curve Fitting Function
"""
"""
    fit(::Type{M}, d::DataFrames.AbstractDataFrame, args::Symbol...) where {M <: Model}

fits the model of type ::Type{M} to the data d.
"""
function fit(::Type{M}, d::DataFrames.AbstractDataFrame, args::Symbol...; celldist::Array{Int64, 1} = [4, 9]) where {M <: AbstractLinearQuadratic}
    """
    example

    fitz(LinearQuadraticModel)
    """
    println("Linear Quadratic Model non overdispersed")
    checker(M, d, args...)
    x = utest(d, args[1], args[2]; celldist = celldist)
    
    x0 = x[args[2]]
    x1 = x[args[2]] .* x[args[3]]
    x2 = x[args[2]] .* x[args[3]] .* x[args[3]]
    
    xdata = DataFrame(x0 = x0, x1 = x1, x2 = x2, aberration = x[args[1]])
    disp_idx = repeat([mean(x[:disp_idx])], inner = size(x)[1])
    weights = 1 ./ disp_idx 

    return glm(@formula(aberration ~ -1 + x0 + x1 + x2), xdata, Poisson(), IdentityLink(), wts = weights)
end

function fit(M::LinearQuadratic, d::DataFrames.AbstractDataFrame, args::Symbol...; celldist::Array{Int64, 1} = [4, 9])
    """
    example

    fitz(LinearQuadraticModel())
    """
    println("Linear Quadratic Model overdispersed")
    checker(AbstractLinearQuadratic, d, args...)
    x = utest(d, args[1], args[2]; celldist = celldist)
    
    x0 = x[args[2]]
    x1 = x[args[2]] .* x[args[3]]
    x2 = x[args[2]] .* x[args[3]] .* x[args[3]]
    
    xdata = DataFrame(x0 = x0, x1 = x1, x2 = x2, aberration = x[args[1]])
    disp_idx = x[:disp_idx]
    weights = 1 ./ disp_idx 
    return glm(@formula(aberration ~ -1 + x0 + x1 + x2), xdata, NegativeBinomial(2.0), LogLink(), wts = weights)
end

function fit(::Type{M}, d::DataFrames.AbstractDataFrame, args::Symbol...; celldist::Array{Int64, 1} = [4, 9]) where {M <: AbstractLinear}
    """
    example

    fitz(Linear)
    """
    println("Linear Model non overdispersed")
    checker(M, d, args...)
    x = utest(d, args[1], args[2]; celldist = celldist)
    
    x0 = x[args[2]]
    x1 = x[args[2]] .* x[args[3]]
    
    xdata = DataFrame(x0 = x0, x1 = x1, aberration = x[args[1]])
    disp_idx = repeat([mean(x[:disp_idx])], inner = size(x)[1])
    weights = 1 ./ disp_idx 
    return glm(@formula(aberration ~ -1 + x0 + x1), xdata, Poisson(), IdentityLink(), wts = weights)
end

function fit(M::Linear, d::DataFrames.AbstractDataFrame, args::Symbol...; celldist::Array{Int64, 1} = [4, 9])
    """
    example

    fitz(Linear())
    """
    println("Linear Model overdispersed")
    checker(AbstractLinear, d, args...)
    x = utest(d, args[1], args[2]; celldist = celldist)
    
    x0 = x[args[2]]
    x1 = x[args[2]] .* x[args[3]]

    xdata = DataFrame(x0 = x0, x1 = x1, aberration = x[args[1]])
    disp_idx = x[:disp_idx]
    weights = 1 ./ disp_idx 
    return glm(@formula(aberration ~ -1 + x0 + x1), xdata, NegativeBinomial(2.0), LogLink(), wts = weights)
end