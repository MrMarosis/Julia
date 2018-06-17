using Gadfly
using DataFrames
using DifferentialEquations
using ParameterizedFunctions

@ode_def LotkaVolterra begin
    dx  = α*x  - β*x*y
    dy = -γ*y + δ*x*y
end α β γ δ
