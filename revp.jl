# sequence/file processing code
function stitch(fasta_file::Vector{String})
    output = ""
    for i in 2:length(fasta_file)
        output *= fasta_file[i]
    end
    return output 
end

# revc solution 
function revc(seq::String)
    revcomp_dict = Dict{Char,String}('A'=>"T",'T'=>"A",'G'=>"C",'C'=>"G")
    revcomp = ""
    for nt in seq; revcomp = revcomp_dict[nt] * revcomp end
    return revcomp
end

#Brute force solution: try every possible reverse palindrome at every position. $O(n\cdot \frac{n}{2} \cdot n) = O(\frac{n^3}{2}) = O(n^3)$

function brute_force(sequence::String, min::Int64 = 4, max::Int64 = 12)
    seqlen = length(sequence)
    output = ""
    for i in 1:seqlen-min+1
        for j in min-1:max-1
            curr_kmer_end = i+j
            if curr_kmer_end <= seqlen
                kmer = sequence[i:curr_kmer_end]
                if kmer == revc(kmer)
                    output *= string(i)*" "*string(curr_kmer_end-i+1)*"\n"
                end
            end
        end
    end
    return output
end

#I/O
input = readlines("inputs/rosalind_revp.txt")
open("outputs/revp.txt","w") do io
    write(io, brute_force(stitch(input)))
end

#However, I think the dynamic programming approach can be $O(n^2)$ if a dynamic programming truth matrix is created 