module Cytogenetics
    using Base.Iterators: flatten, show
    using DataFrames
    using GLM
    using Missings: ismissing, missing
    using Statistics
    using Plots
    # pyplot()

    import StatsBase: fit;

    abstract type AbstractModel end
    abstract type AbstractTest end

    struct UTest{T} <: AbstractTest 
        table::T
        UTest(table) = new{DataFrame}(table)
    end

    mutable struct LinearQuadratic <: AbstractModel
        "`overdispersed`: bool, default `false`, the dispersion of the distribution"
        overdispersed::Bool
        LinearQuadratic(;overdispersed = false) = new(overdispersed)
    end
    
    mutable struct Linear <: AbstractModel
        "`overdispersed`: bool, default `false`, the dispersion of the distribution"
        overdispersed::Bool
        Linear(;overdispersed = false) = new(overdispersed)
    end
    
    Base.show(io::IO, ::MIME"text/plain", z::UTest{T}) where{T} = print(io, "UTest{$T}: Preliminary Test for Overdispersion\n", z.table)
    # Base.show(io::IO, ::MIME"text/plain", z::StatsModels.DataFrameRegressionModel) = print(io, "Linear Quadratic Model: \n Poisson Distribuion", z)
    export 
        AbstractModel,
        AbstractLinear,
        AbstractLinearQuadratic,
        utest
    
    include("checker.jl")
    include("utest.jl")
end