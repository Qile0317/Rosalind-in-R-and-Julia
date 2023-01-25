#heap's algorithm. it should be made into strs for more speed
perms(l) = isempty(l) ? [l] : [[x; y] for x in l for y in perms(setdiff(l, x))] 

function vec_to_str(vec::Vector)
    output = ""
    for term in vec
        output *= string(term)*" "
    end
    return output*"\n"
end

function perm(num::Int64)
    vec_ans = perms(1:num)
    answer = string(factorial(num))*"\n"
    for vec in vec_ans
        answer *= vec_to_str(vec)
    end
    return answer
end

#I/O
input = 6 #from rosalind
open("outputs/perm.txt","w") do io
    write(io,perm(input))
end