function diffgraph(ex::Expr, indentation::Int64=0)#::Expr
    println(repeat(" ",indentation), typeof(ex.args[1]))
    println(repeat(" ",indentation), ex.args[1])

    if typeof(ex.args[2]) == Expr
        diffgraph(ex.args[2], indentation+=1)
    else
        println(repeat(" ",indentation), typeof(ex.args[2]))
        println(repeat(" ",indentation), ex.args[2])
    end
    if typeof(ex.args[3]) == Expr
        diffgraph(ex.args[3], indentation+=1)
    else
        println(repeat(" ",indentation), typeof(ex.args[3]))
        println(repeat(" ",indentation), ex.args[3])
    end
end






function autodiff(ex::Expr)#::Expr
    println(typeof(ex.args[1]))
    println(ex.args[1])

    if ex.args[1]==-

    end


    ex.args[2] = autodiff(ex.args[2])
    ex.args[3] = autodiff(ex.args[3])
    dump(ex)
end

function autodiff(num::Number)
    return 0
end

function autodiff(x::Symbol)
    return 1
end

#function autodiff(x::Sym) 

ex3 = parse("2+x")

