#get seqs
function get_seqs(fasta_file_location::String)
    fasta_file = readlines(fasta_file_location)
    output = String[]
    curr_seq = ""
    for i in 1:length(fasta_file)
        if i != 1
            if fasta_file[i][1] == '>'
                push!(output, curr_seq)
                curr_seq = ""
            else
                curr_seq *= fasta_file[i]
            end
        end
    end
    push!(output, curr_seq)
    return output
end

# get pairwise p distance
function dp(seq1::String, seq2::String)
    n, tot_diff = length(seq1), 0
    for i in 1:n
        if seq1[i] != seq2[i]
            tot_diff += 1
        end
    end
    return tot_diff/n
end

# iterate and construct matrix
function construct_matrix(seqs::Vector{String})
    n = length(seqs)
    dist_matrix = zeros(Float64, n,n)
    for i in 1:n
        for j in 1:n
            if i == j # could store in a dict of reversed i-j tuples!
                dist_matrix[i, j] = 0.0
            else
                dist_matrix[i, j] = dp(seqs[i], seqs[j])
            end
        end
    end
    return dist_matrix
end

# turn matrix into string for writing. technically couldve been done before but this is better practisce
function pdst(dist_matrix::Matrix{Float64})
    dim = Int64(sqrt(length(dist_matrix)))
    output = ""
    for i in eachindex(dist_matrix)
        output *= string(dist_matrix[i])
        if i%dim == 0
            output *= "\n"
        else
            output *= " "
        end
    end
    return output[1:end-1]
end

#I/O 
input_seqs = get_seqs("inputs/rosalind_pdst.txt")
open("outputs/pdst.txt", "w") do io
    write(io, pdst(construct_matrix(input_seqs)))
end