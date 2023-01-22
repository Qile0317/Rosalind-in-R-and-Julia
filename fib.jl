#Fₙ = F_(n-1) + k*F_(n-2)
function population(n::Int64,k::Int64) #assumes k > 1
    if n == 1 || n == 2 ; return println(1) end
    dp0, dp1, dp2 = 1,1, k+1 #dp2 is basically a storage variable
    for i in 3:n
        dp2 = dp0*k + dp1 
        dp0 = dp1
        dp1 = dp2 
    end
    return println(dp2)
end

population(31,4) #1117836738901
    