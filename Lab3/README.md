# Optimization of Graph module

## Measurements
All tests were conducted using [BenchmarkTools.jl](https://raw.githubusercontent.com/JuliaCI/BenchmarkTools.jl), 
which is a benchmarking framework for Julia Language.
While most of the parameters of the benchmarking process remained unchanged (set to default), 
the number of seconds budget for a trial was increased to 100 seconds.

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

### Changing return values to be specific
```
BenchmarkTools.Trial: 
  memory estimate:  3.79 GiB
  allocs estimate:  5472166
  --------------
  minimum time:     2.040 s (12.37% GC)
  median time:      2.076 s (12.46% GC)
  mean time:        2.076 s (12.61% GC)
  maximum time:     2.187 s (16.20% GC)
  --------------
  samples:          49
  evals/sample:     1
```

### Removing modifiable global variable
```
BenchmarkTools.Trial: 
  memory estimate:  3.76 GiB
  allocs estimate:  3930065
  --------------
  minimum time:     1.798 s (18.21% GC)
  median time:      1.929 s (22.06% GC)
  mean time:        1.914 s (21.58% GC)
  maximum time:     1.956 s (22.36% GC)
  --------------
  samples:          53
  evals/sample:     1

```

### Adding signatures of method parameteres and their return types
```
BenchmarkTools.Trial: 
  memory estimate:  3.76 GiB
  allocs estimate:  3930947
  --------------
  minimum time:     1.798 s (17.49% GC)
  median time:      1.900 s (21.33% GC)
  mean time:        1.896 s (20.76% GC)
  maximum time:     1.998 s (21.06% GC)
  --------------
  samples:          53
  evals/sample:     1
  
```

###Changing graph edges' array to be bitArray
```
BenchmarkTools.Trial: 
  memory estimate:  3.29 GiB
  allocs estimate:  3850323
  --------------
  minimum time:     1.552 s (18.53% GC)
  median time:      1.628 s (18.84% GC)
  mean time:        1.633 s (18.94% GC)
  maximum time:     1.738 s (23.11% GC)
  --------------
  samples:          62
  evals/sample:     1

```

### Breaking functions into multiple definitions
```
BenchmarkTools.Trial: 
  memory estimate:  3.29 GiB
  allocs estimate:  3722769
  --------------
  minimum time:     1.482 s (19.87% GC)
  median time:      1.535 s (19.67% GC)
  mean time:        1.552 s (19.64% GC)
  maximum time:     1.784 s (18.98% GC)
  --------------
  samples:          65
  evals/sample:     1

```

