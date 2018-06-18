using Gadfly
using DataFrames
using DifferentialEquations
using ParameterizedFunctions

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
    df[:experiment] = fill(no,size(df, 1))
    writetable(savePath,df)
end

print(typeof(f))
#print(typeof(solveLV))