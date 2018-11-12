"""
    fit(::Type{M}, d::DataFrames.AbstractDataFrame, args::Symbol...) where {M <: Model}

fits the model of type ::Type{M} to the data d.
"""
function fit(::Type{M}, df::DataFrame, args::Symbol...) where M <: AbstractModel
    """
    example

    fitz(LinearQuadraticModel)
    """
    println("Linear Quadratic Model non overdispersed")
    checker(M, df, args...)
    modeldf, model = prepdata(M, df, args...)
    dis_idx = repeat([mean(df[:disp_idx])], inner = size(df)[1])
    weights = 1 ./ dis_idx 

    return glm(model, modeldf, Poisson(), IdentityLink(), wts = weights)
end

function fit(M::LinearQuadratic, df::DataFrame, args::Symbol...)
    """
    example

    fitz(LinearQuadraticModel)
    """
    println("Linear Quadratic Model overdispersed")
    checker(M, df, args...)
    modeldf, model = prepdata(M, df, args...)
    
    if M.overdispersed
        dis_idx = df[:disp_idx]
        weights = 1 ./ dis_idx 
        family  = NegativeBinomial(2.0)
        link    = LogLink()
    else
        dis_idx = repeat([mean(df[:disp_idx])], inner = size(df)[1])
        weights = 1 ./ dis_idx 
        family  = Poisson(2.0)
        link    = IdentityLink()
    end

    return glm(model, modeldf, family, link, wts = weights)
end

fit(::Type{LinearQuadratic}, df::UTest{DataFrame}, args::Symbol...) = fit(LinearQuadratic, df.table, args...)
fit(::Type{Linear}, df::UTest{DataFrame}, args::Symbol...) = fit(Linear, df.table, args...)

function prepdata(::Type{LinearQuadratic}, df::DataFrame, args::Symbol...)
    x0 = df[args[2]]
    x1 = df[args[2]] .* df[args[3]]
    x2 = df[args[2]] .* df[args[3]] .^ 2
    modeldf = DataFrame(x0 = x0, x1 = x1, x2 = x2, aberration = df[args[1]])
    model   = @formula(aberration ~ -1 + x0 + x1 + x2)
    return (modeldf, model)
end

function prepdata(::Type{Linear}, df::DataFrame, args::Symbol...)
    x0 = df[args[2]]
    x1 = df[args[2]] .* df[args[3]]
    modeldf = DataFrame(x0 = x0, x1 = x1, aberration = df[args[1]])
    model   = @formula(aberration ~ -1 + x0 + x1)
    return (modeldf, model)
end

# function fit(M::LinearQuadratic, d::DataFrames.AbstractDataFrame, args::Symbol...; celldist::Array{Int64, 1} = [4, 9])
#     """
#     example

#     fitz(LinearQuadraticModel())
#     """
#     println("Linear Quadratic Model overdispersed")
#     checker(AbstractLinearQuadratic, d, args...)
#     x = utest(d, args[1], args[2]; celldist = celldist)
    
#     x0 = x[args[2]]
#     x1 = x[args[2]] .* x[args[3]]
#     x2 = x[args[2]] .* x[args[3]] .* x[args[3]]
    
#     xdata = DataFrame(x0 = x0, x1 = x1, x2 = x2, aberration = x[args[1]])
#     disp_idx = x[:disp_idx]
#     weights = 1 ./ disp_idx 
#     return glm(@formula(aberration ~ -1 + x0 + x1 + x2), xdata, NegativeBinomial(2.0), LogLink(), wts = weights)
# end

# function fit(::Type{M}, d::DataFrames.AbstractDataFrame, args::Symbol...; celldist::Array{Int64, 1} = [4, 9]) where {M <: AbstractLinear}
#     """
#     example

#     fitz(Linear)
#     """
#     println("Linear Model non overdispersed")
#     checker(M, d, args...)
#     x = utest(d, args[1], args[2]; celldist = celldist)
    
#     x0 = x[args[2]]
#     x1 = x[args[2]] .* x[args[3]]
    
#     xdata = DataFrame(x0 = x0, x1 = x1, aberration = x[args[1]])
#     disp_idx = repeat([mean(x[:disp_idx])], inner = size(x)[1])
#     weights = 1 ./ disp_idx 
#     return glm(@formula(aberration ~ -1 + x0 + x1), xdata, Poisson(), IdentityLink(), wts = weights)
# end

# function fit(M::Linear, d::DataFrames.AbstractDataFrame, args::Symbol...; celldist::Array{Int64, 1} = [4, 9])
#     """
#     example

#     fitz(Linear())
#     """
#     println("Linear Model overdispersed")
#     checker(AbstractLinear, d, args...)
#     x = utest(d, args[1], args[2]; celldist = celldist)
    
#     x0 = x[args[2]]
#     x1 = x[args[2]] .* x[args[3]]

#     xdata = DataFrame(x0 = x0, x1 = x1, aberration = x[args[1]])
#     disp_idx = x[:disp_idx]
#     weights = 1 ./ disp_idx 
#     return glm(@formula(aberration ~ -1 + x0 + x1), xdata, NegativeBinomial(2.0), LogLink(), wts = weights)
# end