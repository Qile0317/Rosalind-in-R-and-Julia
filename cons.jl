#https://rosalind.info/problems/cons/
# solution assumes there is only 1 consensus!

Nt_dict = Dict( 'A' => 1,
                'C' => 2,
                'G' => 3,
                'T' => 4)

Num_dict = Dict(1=>"A",
                2=>"C",
                3=>"G",
                4=>"T")

function printvec(vec::Vector{Int64})
    output = ""
    for num in vec
        output *= string(num)*" "
    end
    return output
end

function is_sequence(line::String) #fasta file processing
    return '>' != line[1]
end

function get_seqlength(fasta_file::Vector{String}) #takes 1st fasta file length
    len = 0 
    for i in 2:length(fasta_file)
        line = fasta_file[i]
        if is_sequence(line)
            len += length(line)
        else
            return len
        end
    end
end

"""
    consensus_seq(consensus::Vector{Vector{Int64}})

returns consensus sequence from a concensus matrix, via the brute force method
"""
function consensus_seq(consensus::Vector{Vector{Int64}})
    curr_max, curr_cons_max = fill("A",length(consensus[1])), copy(consensus[1])
    for i in 2:4
        curr = consensus[i]
        for j in 1:length(curr)
            if curr[j] > curr_cons_max[j]
                curr_cons_max[j] = curr[j]
                curr_max[j] = Num_dict[i]
            end
        end
    end
    return join(curr_max)
end

#this is the most basic solution i can think of thats O(n) by iterating
#matrix should be used and revamp
"""
    consensus(fasta_file::Vector{String})

Constructs the consensus matrix for a fasta file as a vector of strings
"""
function consensus(fasta_file::Vector{String})
    curr_index = 0
    len = get_seqlength(fasta_file)
    output = [zeros(Int64,len) for _ in 1:4]
    for line in fasta_file
        if is_sequence(line)
            for Nt in line
                curr_index += 1
                nucleotide_row = Nt_dict[Nt]
                output[nucleotide_row][curr_index] += 1
            end
        else #if its the identifier
            curr_index = 0 
        end
    end
    answer = consensus_seq(output)*"\n"
    for i in 1:4
        answer *= Num_dict[i]*": "*printvec(output[i])*"\n"
    end
    return answer[1:end-2]
end

#I/O 
open("outputs/cons.txt","w") do io
    write(io,consensus(readlines("inputs/rosalind_cons.txt")))
end #8457