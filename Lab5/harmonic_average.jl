function init_harmonicAV(parts...)
    sum= :(0)
    for i in parts
        sum= :($sum+(1/$i))
    end
    return :(length($parts)/$sum)
end

@generated function harmonicAV(parts...)
    return init_harmonicAV(parts)
end