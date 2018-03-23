function printTypeGraphInheritance(var)
    if supertype(var) == supertype(supertype(var))
        println("Any")
    else
        print(supertype(var),"--->")
        printTypeGraphInheritance(supertype(var))
    end
end

#printTypeGraphInheritance(Int)
