#memoization solution
function fibd(n::Int,m::Int)
    if n == 1 || n == 2; return println(1) end #edge case
    dp = [1,1]
    for i in 3:n
        if i == m+1
            push!(dp, dp[i-1] + dp[i-2] - 1)
        elseif i > m+1 
            push!(dp, dp[i-1] + dp[i-2] - dp[i-m-1]) #doesnt work
        else
            push!(dp, dp[i-1] + dp[i-2])
        end
    end
    return println(dp[n])
end

fibd(82,17) #60794189349730026
