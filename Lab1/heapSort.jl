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

function maxHeapify!(A,i,h)
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
        maxHeapify!(A,max,h)
    end
end

 function buildMaxHeap!(A)
    half_arr_size=trunc(Int,(size(A,1))/2)
    i=half_arr_size+1
    while i >=1
         maxHeapify!(A,i,size(A,1))
         i-=1
    end
end

function heapSort!(A)
    buildMaxHeap!(A)
    i=size(A,1)
    while i>=1
        swap!(A,1,i)
        maxHeapify!(A,1,i-1)
        i-=1
    end
end


a=[5,8,3,1]
heapSort!(a)
println(a)
