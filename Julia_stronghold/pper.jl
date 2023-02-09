function pper(n::Int64, r::Int64)
    return BigInt((factorial(big(n))/factorial(big(n-r)))%1e6)
end

pper(91,8) # 838400

# for truly large values, modulo and iterative tricks can be used.