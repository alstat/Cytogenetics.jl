"""
    fit(::Type{M}, d::DataFrames.AbstractDataFrame, args::Symbol...) where {M <: Model}

fits the model of type ::Type{M} to the data d.
"""
function fit(M::T, df::UTest{DataFrame}, args::Symbol...) where T <: AbstractModel
    """
    example

    fitz(LinearQuadraticModel)
    """
    
    checker(M, df.table, args...)
    modeldf, model = prepdata(M, df.table, args...)
    
    if M.overdispersed
        println("Linear Quadratic Model overdispersed")
        dis_idx = df.table[:disp_idx]
        weights = 1 ./ dis_idx 
        family  = NegativeBinomial(2.0)
        link    = LogLink()
    else
        println("Linear Quadratic Model non overdispersed")
        dis_idx = repeat([mean(df.table[:disp_idx])], inner = size(df.table)[1])
        weights = 1 ./ dis_idx 
        family  = Poisson(2.0)
        link    = IdentityLink()
    end

    return glm(model, modeldf, family, link, wts = weights)
end

fit(::Type{Linear}, df::UTest{DataFrame}, args::Symbol...) = fit(Linear(), df, args...)
fit(::Type{LinearQuadratic}, df::UTest{DataFrame}, args::Symbol...) = fit(LinearQuadratic(), df, args...)

function prepdata(::Type{Linear}, df::DataFrame, args::Symbol...)
    x0 = df[args[2]]
    x1 = df[args[2]] .* df[args[3]]
    modeldf = DataFrame(x0 = x0, x1 = x1, aberration = df[args[1]])
    model   = @formula(aberration ~ -1 + x0 + x1)
    return (modeldf, model)
end

function prepdata(::Type{LinearQuadratic}, df::DataFrame, args::Symbol...)
    x0 = df[args[2]]
    x1 = df[args[2]] .* df[args[3]]
    x2 = df[args[2]] .* df[args[3]] .^ 2
    modeldf = DataFrame(x0 = x0, x1 = x1, x2 = x2, aberration = df[args[1]])
    model   = @formula(aberration ~ -1 + x0 + x1 + x2)
    return (modeldf, model)
end

prepdata(M::Linear, df::DataFrame, args::Symbol...) = prepdata(Linear, df, args...)
prepdata(M::LinearQuadratic, df::DataFrame, args::Symbol...) = prepdata(LinearQuadratic, df, args...)