using Gadfly
using DataFrames
using DifferentialEquations
using ParameterizedFunctions
using CSV

@ode_def LotkaVolterra begin
    dx  = α*x  - β*x*y
    dy = -γ*y + δ*x*y
end α β γ δ

function solveLV(u0::Array{Float64,1},p::Array{Float64,1})
    f = LotkaVolterra()
    tspan = (0.0,10.0)
    prob = ODEProblem(f, u0, tspan, p)
    sol = solve(prob, RK4(), dt = 0.01)
    return DataFrame(t = sol.t, x = map(x -> x[1], sol.u), y = map(x -> x[2], sol.u))
end 

function saveDF(df::DataFrames.DataFrame, no::Int64, savePath = "results.csv")
    df[:experiment] = fill("exp$no",size(df, 1))
    CSV.write(savePath, df, delim = ',')
end

function genCSV(noSamples::Int64,vars::Int64 = 2,params::Int64=4)
    for i = 1:noSamples
        saveDF(solveLV(rand(vars)*10, rand(params)*10), i, "results$i.csv")
    end
end

function analData(no::Int64)
    df = DataFrame(t = Float64[], x = Float64[], y = Float64[], exp=String[])

    for i=1:no
        df = CSV.read("results$i.csv", df; append=true)
        tdf = df[df[:experiment] .== "exp$i", :]
        @printf("results %d pray:     min %10.7F max %10.7F mean %10.7F\n", i, minimum(tdf[:x]), maximum(tdf[:x]), mean(tdf[:x]))
        @printf("results %d predator: min %10.7F max %10.7F mean %10.7F\n", i, minimum(tdf[:x]), maximum(tdf[:x]), mean(tdf[:x]))
        @printf("-----------------------------------------------------------------\n")
    end
    df[:diffrence] = df[:y] - df[:x]
    #show(df)
end