function log10_probability(nt::Char, gc_content::Float64)
    if nt == 'C' || nt == 'G'
        return log10(gc_content*0.5)
    else
        return log10((1-gc_content)*0.5)
    end
end

function log10_seq_prob(seq::String,gc_content::Float64)
    log_10_prob = 0
    for nt in seq
        log_10_prob += log10_probability(nt,gc_content)
    end
    return log_10_prob
end

function prob(seq::String, GC_probs::Vector{Float64})
    output_probs = ""
    for k in 1:length(probs)
        output_probs *= string(log10_seq_prob(seq,GC_probs[k]))*" "
    end
    return output_probs
end

#I/O 
input = readlines("inputs/rosalind_prob.txt")
seq = input[1]
probs = parse.(Float64, split(input[2]))
println(prob(seq,probs))

#-83.60022231538966 -70.54486093723906 -66.57391860973316 -62.16120823085505 -59.34713621078248 -58.08919331699862 -57.7752992422476 -57.874725226669774 -59.22047682192209 -60.39639950554514 -62.621095647716935 -65.11738567375029 -71.62710450080124 -84.43772349192703