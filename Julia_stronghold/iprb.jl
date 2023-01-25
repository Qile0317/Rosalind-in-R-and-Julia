function iprb(k,m,n)
    i = m * m + 4 * n * n + 4 * m * n - 4 * n - m
    j = 4 * (k + m + n) * (k + m + n - 1)
    return 1-(i/j)
end

iprb(26,22,17) #0.8169471153846154