#pre pocessing 
function is_sequence(line::String)
    return line[1] != '>'
end

#get the two sequences, the first is s and the second is t
function get_seqs(fasta_file::Vector{String})
    output = ["",""]
    seq_count = 0 
    for line in fasta_file
        if !is_sequence(line)
            seq_count += 1
        else
            output[seq_count] *= line 
        end
    end
    return output
end

function sseq(seq::String, query::String)
    output = ""
    next_ind = 1
    lq = length(query)
    next_nt = query[next_ind]
    for i in 1:length(seq)
        curr_nt = seq[i]
        if next_ind <= lq
            if curr_nt == next_nt
                output *= string(i)*" "
                if next_ind == lq
                    return output
                else
                    next_ind += 1
                    next_nt = query[next_ind]
                end
            end
        end
    end
    return output
end

#I/O 
fasta_file = readlines("inputs/rosalind_sseq.txt")
seqs = get_seqs(fasta_file)
input, query = seqs[1], seqs[2]
println(sseq(input,query))

#2 6 10 11 13 20 26 32 35 38 43 53 54 55 58 59 68 72 76 77 78 79 81 83 84 98 100 101 115 123 124 127 133 135 136 145 146 147 153 154 156 163 174 181 184 193 194 202 203 205 206 211 212 213 214 220 226 231 241 246 247 249 253 254 258 259 262 269 271 276 281 282 289 293 294 297 300 305 307 308 313 329 335 337 338 339 340 342 345 355 368 370 371 378 382 385 388 391 392