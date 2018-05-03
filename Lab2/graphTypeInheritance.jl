function printTypeGraphInheritance(var)
    if supertype(var) != supertype(supertype(var))
        printTypeGraphInheritance(supertype(var))
        print("--->",supertype(var))
    else
        print("Any")
    end
end
