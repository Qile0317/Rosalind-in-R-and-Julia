function get_seqs(fasta_file::Vector{String}, n::Int64)
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

function pmch(seq::String)
    GCpair_count, n = 0, length(seq)
    for i in 1:n; if seq[i] == 'G'; GCpair_count += 1 end end
    AC_paircount = 0.5*(n - 2*GCpair_count)
    output = factorial(big(GCpair_count)) * factorial(big(AC_paircount))
    print(BigInt(output))
end

#I/O 
input = readlines("inputs/rosalind_pmch.txt")
seq = get_seqs(input, 1)[1]
pmch(seq)