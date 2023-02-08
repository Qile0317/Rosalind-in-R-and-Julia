function is_sequence(line::String)
    return '>' != line[1]
end

function get_seq_gc(dna::String)
    GC_set = Set(['G','C'])
    GC_count = 0
    for nt in dna
        if nt in GC_set; GC_count += 1 end
    end
    return GC_count 
end

#the macro @view could be used to speed up code and memory usage 
function gc(fasta_file::Vector{String})
    max_gc = ["identifier",-Inf]
    curr_seq_len, curr_GC, filelen = 1, 0, length(fasta_file)
    curr_identifier = fasta_file[1]

    for i in 1:length(fasta_file)
        if is_sequence(fasta_file[i])
            curr_GC += get_seq_gc(fasta_file[i])
            curr_seq_len += length(fasta_file[i])
        else
            curr_GC /= curr_seq_len 
            if max_gc[2] < curr_GC
                max_gc[2] = curr_GC
                max_gc[1] = curr_identifier
            end
            curr_GC, curr_seq_len = 0, 0
            curr_identifier = fasta_file[i]
        end
    end
    return println(max_gc[1][2:end]*"\n"*string(max_gc[2]*100))
end

#I/O 
input = readlines("inputs/rosalind_gc.txt")
gc(input)

# Rosalind_8003
# 52.04419889502763