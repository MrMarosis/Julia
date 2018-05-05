# Optimization of Graph module

## Measurements
All tests were conducted using [BenchmarkTools.jl](https://raw.githubusercontent.com/JuliaCI/BenchmarkTools.jl), 
which is a benchmarking framework for Julia Language.
While most of the parameters of the benchmarking process remained unchanged (set to default), 
the number of seconds budget for a trial was increased to 120 seconds.

### Initial results:
```
BenchmarkTools.Trial: 
  memory estimate:  6.52 GiB
  allocs estimate:  121806395
  --------------
  minimum time:     11.470 s (12.95% GC)
  median time:      11.895 s (13.75% GC)
  mean time:        12.216 s (13.42% GC)
  maximum time:     14.104 s (13.30% GC)
  --------------
  samples:          9
  evals/sample:     1
```
