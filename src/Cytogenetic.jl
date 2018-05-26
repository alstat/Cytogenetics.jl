module Cytogenetic
    using Base.Iterators: flatten
    using DataFrames
    using DataFramesMeta
    using GLM
    using Lazy: @>
    using Missings: ismissing, missing

    import StatsBase: fit;

    abstract type AbstractModel end
    abstract type AbstractLinear <: AbstractModel end
    abstract type AbstractLinearQuadratic <: AbstractModel end
    abstract type AbstractTest end

    mutable struct LinearQuadraticModel <: AbstractLinearQuadratic 
        "`overdispersed`: bool, default `false`, the dispersion of the distribution"
        overdispersed::Bool
        LinearQuadraticModel(overdispersed = false) = new(overdispersed)
    end

    export 
        AbstractModel,
        AbstractLinear,
        AbstractLinearQuadratic,
        utest
    
    include("checker.jl")
    include("utest.jl")
end