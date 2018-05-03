import Base.*
import Base.^
import Base.convert
import Base.promote_rule

function gcd(a, b) #Euclides algorithm
    while b != 0
        a,b = b, a%b
    end
    return a
end

struct Gn{N}
    x::Integer
    function Gn{N}(x) where N
            if x<0 || N<0
                error("x or N equals 0")
            elseif N<1
                error("N has to be bigger than 0")
            elseif gcd(x,N)!=1
                throw(DomainError())
            else
                new(x%N)
            end
    end
end

function *(G1::Gn,G2::Gn)
    if(typeof(G1)!=typeof(G2))
        error("Arguments have to be of the same modulo type!")
    else
        return typeof(G1)(G1.x*G2.x)
    end
end

convert(::Type{Gn{N}},number::Int64) where N = Gn{N}(number)

convert(::Int64,G::Type{Gn{N}}) where N = G.x

promote_rule(G::Type{Gn{N}},num::Type{T}) where {N,T<:Integer} = promote(G.x,num)

function ^(a::Gn{N},x::T) where {N,T<:Integer}
    result = a.x
    for i = 2:x
        result=(result*a.x)
        result%=N
    end
    return result
end

function repetition_period(G::Gn{N}) where N
    r = 1
    while (^(G, r) != 1)
        r = r + 1
    end
    if r <= N return r
    else throw(DomainError)
    end
end

function xgcd(a,b) #Extended Euclides Algorithm
    x,y, u,v = 0,1, 1,0
    while a!=0
        q, r = floor(b // a), b % a
        m, n = x-u*q, y-v*q
        b,a, x,y, u,v = a,r, u,v, m,n
    end
    return b, x, y
end

function get_num_elements(Gn::Type{Gn{N}}) where N
    num_elements::Int8=1 #Counting 0
    for i = 1:N
        if(gcd(i,N)==1)
            num_elements+=1
        end
    end
    return num_elements
end

#Given public key N = 55, c = 17 and encoded message b = 4
N=55
c=17
b=4
#Calculate period r of message b in a multiplicative algebraic group Gn{N}
r = repetition_period(Gn{N}(b))
println("repetition period = ",r)
#Calculate d - modular multiplicative inverse of c in Gn{r}. It's a private key
d = Int16(xgcd(c,N)[2])
println("Inveresed element = ", Int16(d))
#Decoded message
a = b^d %N
#Check if the coding (N,k) is correct
println("Decoded msg: ", a)
println(a^c % N)
println(b)
println(a^c % N == b ? "Coding is correct" : "Coding is wrong")
