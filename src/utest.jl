"""
    utest(d::AbstractDataFrame, args::Symbol...; celldist::Array = [4, 9])

function for computing the u test statistics of the distribution of the dicentrics
"""
function utest(d::AbstractDataFrame, args::Symbol...; celldist::Array = [4, 9])
    checker(AbstractTest, d, args...)
    disp_idx = Float64[]; u_test = []; desc = [];

    for i = 1:nrow(d)
        xs = Array{Int}[];
        for j = 0:diff(celldist)[1]
            if isna(d[i, celldist[1]:celldist[2]][j + 1][1]) || d[i, celldist[1]:celldist[2]][j + 1][1] == 0
                break
            else  
                push!(xs, repeat([j], inner = d[i, celldist[1]:celldist[2]][j + 1]))
            end
        end
        inp = collect(flatten(xs))
        push!(disp_idx, var(inp) / mean(inp))

        if d[i, args[1]] == 1
            push!(u_test, missing)
            push!(desc, missing)
        else
            push!(u_test, (disp_idx[i] - 1) * sqrt((d[i, args[2]] - 1) / (2 * (1 - (1 / d[i, args[1]])))))
            push!(desc, -1.96 <= u_test[i] <= 1.96 ? "poisson" : u_test[i] > 1.96 ? "over-dispersed" : "under-dispersed")
        end
    end

    d[:disp_idx] = disp_idx
    d[:u_test] = u_test
    d[:distribution] = desc

    return d
end