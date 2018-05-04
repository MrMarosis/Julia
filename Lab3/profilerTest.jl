import Base.Random.randstring

function genStrings(n)
    for _ = 1:n
        x = Base.Random.randstring(20)
    end
end

function fun1()
    genStrings(100000)
end

function fun2()
    genStrings(10000)
end

function benchmark()
    for _ = 1:500
        fun1()
        fun2()
    end
end

benchmark()
Profile.clear()
Profile.init(n = 10^7, delay = 0.01)
@profile benchmark()
Profile.print()

using ProfileView
ProfileView.view()

using BenchmarkTools
@benchmark benchmark
