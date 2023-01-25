const probs = [1,1,1,0.75,0.5,0].*2

function iev(nums::Vector{Int64})
    output = 0
    for i in 1:length(nums)
        output += nums[i]*probs[i]
    end
    return output
end

iev([17334,17546,18182,19771,18747,17607]) #154527.5