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

### Changing global variables to be constant
```
BenchmarkTools.Trial: 
  memory estimate:  3.79 GiB
  allocs estimate:  5469821
  --------------
  minimum time:     1.997 s (10.77% GC)
  median time:      2.041 s (10.62% GC)
  mean time:        2.086 s (10.67% GC)
  maximum time:     2.467 s (10.29% GC)
  --------------
  samples:          48
  evals/sample:     1
```
