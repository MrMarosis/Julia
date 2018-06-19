using Gadfly
using DataFrames
using DifferentialEquations
using ParameterizedFunctions
using CSV

Gadfly.push_theme(:dark)

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
        @printf("results %d prey:     min %10.7F max %10.7F mean %10.7F\n", i, minimum(tdf[:x]), maximum(tdf[:x]), mean(tdf[:x]))
        @printf("results %d predator: min %10.7F max %10.7F mean %10.7F\n", i, minimum(tdf[:x]), maximum(tdf[:x]), mean(tdf[:x]))
        @printf("-----------------------------------------------------------------\n")
    end
    df[:difference] = df[:y] - df[:x]
    return df
end

function drawTimeGraph(df::DataFrames.DataFrame)
    experiments = unique(df[:experiment])
    
    for experiment in experiments
        expDF = df[df[:experiment] .== experiment, :]
            p = plot(expDF, layer(y = "y", x = "t", Geom.line, Theme(default_color=colorant"orange")),
            layer(y = "x", x = "t", Geom.line, Theme(default_color=colorant"purple")),
            layer(y = "difference", x = "t", Geom.line),
            Guide.YLabel("population"),
            Guide.Title(experiment));
            
            draw(PNG("$experiment.png", 30cm, 30cm), p)
    end

    plot(df, Geom.subplot_grid(
        layer(ygroup="experiment", x="t", y="x", Geom.line, Theme(default_color=colorant"purple")),
        layer(ygroup="experiment", x="t", y="y", Geom.line, Theme(default_color=colorant"green")), 
        layer(ygroup="experiment", x="t", y="difference", Geom.line, Theme(default_color=colorant"pink")),
        free_y_axis=true
    )
    )
end

function drawPhaseGraph(df::DataFrames.DataFrame)
    experiments = unique(df[:experiment])
    layers = Vector{Gadfly.Layer}()
    colors = [colorant"red", colorant"blue", colorant"green", colorant"magenta", colorant"cyan", colorant"yellow", colorant"orange", colorant"black"]

    for i in 1:length(experiments)
        expDF = df[df[:experiment] .== experiments[i], :]
        usedColor = color(colors[i % length(colors) + 1])
        push!(layers, layer(expDF, x = "x", y = "y", Geom.line(preserve_order = true), Theme(default_color = usedColor))...)
    end

    set_default_plot_size(25cm, 25cm)
    plot(layers, Guide.YLabel("predators"), Guide.XLabel("prey"), Guide.Title("Population"))
end