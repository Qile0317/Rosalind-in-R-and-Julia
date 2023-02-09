function get_seqs(fasta_file::Vector{String}, n::Int64 = 1)
    output, seq_count = fill("", n), 0
    for line in fasta_file
        if seq_count > n; return output end
        if line[1] == '>'
            seq_count += 1
        else
            output[seq_count] *= line 
        end
    end
    return output
end

function countNT(seq::String)
    NTs, counts = Dict{Char,Int64}('A'=> 1,'C' => 2,'G' => 3,'U' => 4), [0,0,0,0]
    for nt in seq; counts[NTs[nt]] += 1 end
    return counts
end

function mmch(counts::Vector{Int64})
    min_AU, max_AU = sort([counts[1], counts[4]])
    min_GC, max_GC = sort([counts[2], counts[3]])
    return BigInt((factorial(big(max_AU))/factorial(big(max_AU-min_AU)))*(factorial(big(max_GC))/factorial(max_GC-min_GC)))
end

# I/O
input = readlines("inputs/rosalind_mmch.txt")
seq = get_seqs(input, 1)[1]
print(mmch(countNT(seq)))