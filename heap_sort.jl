function getparent(x)
    return floor(x/2)
end
function getleft(x)
    return floor(2*x)
end
function getright(x)
    return floor(2*x+1)
end

function swap!(A,a,b)
    tmp=A[a]
    A[a] = A[b]
    A[b]=tmp
end

function max_heapify!(A,i,h)
    max = i
    l = getleft(i)
    r = getright(i)
    if(l<=h && A[l]>A[max])
        max=l
    end
    if(r<=h && A[r]>A[max])
        max=r
    end

    if(max!=i)
        swap!(A,i,max)
        max_heapify!(A,max,h)
    end
end

 function build_max_heap!(A)
    half_arr_size=trunc(Int,(size(A,1))/2)
    i=half_arr_size+1
    while i >=1
         max_heapify!(A,i,size(A,1))
         i-=1
    end
end

function heap_sort!(A)
    build_max_heap!(A)
    i=size(A,1)
    while i>=1
        swap!(A,1,i)
        max_heapify!(A,1,i-1)
        i-=1
    end
end


a=[5,8,3,1]
heap_sort!(a)
#max_heapify!(a,1,4)
println(a)
