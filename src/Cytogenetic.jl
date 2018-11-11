module Cytogenetic
    using Base.Iterators: flatten
    using DataFrames
    using DataFramesMeta
    using GLM
    using Missings: ismissing, missing
    using Statistics

    import StatsBase: fit;

    abstract type AbstractModel end
    abstract type AbstractLinear <: AbstractModel end
    abstract type AbstractLinearQuadratic <: AbstractModel end
    
    abstract type AbstractTest end
    abstract type AbstractUTest <: AbstractTest end

    mutable struct LinearQuadratic <: AbstractLinearQuadratic 
        "`overdispersed`: bool, default `false`, the dispersion of the distribution"
        overdispersed::Bool
        LinearQuadratic(;overdispersed = false) = new(overdispersed)
    end
    
    mutable struct Linear <: AbstractLinear
        "`overdispersed`: bool, default `false`, the dispersion of the distribution"
        overdispersed::Bool
        Linear(;overdispersed = false) = new(overdispersed)
    end

    export 
        AbstractModel,
        AbstractLinear,
        AbstractLinearQuadratic,
        utest
    
    include("checker.jl")
    include("utest.jl")
end