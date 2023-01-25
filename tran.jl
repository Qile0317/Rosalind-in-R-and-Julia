#I know that stitching sequences are not the best practisce but im doing it for simplicity sake

#pre pocessing 
function is_sequence(line::String)
    return line[1] != '>'
end

#get the two sequences, the first is s and the second is t
function get_seqs(fasta_file::Vector{String})
    output = String[]
    seq_count = 0 
    for line in fasta_file
        if !is_sequence(line)
            seq_count += 1
            push!(output, "")
        else
            output[seq_count] *= line 
        end
    end
    return output
end

#check if the change was a transition.
function is_transition(nt1::Char,nt2::Char)
    if nt1 == 'C' 
        nt2 == 'T' ? (return true) : (return false)

    elseif nt1 == 'G'
        nt2 == 'A' ? (return true) : (return false)

    elseif nt1 == 'A'
        nt2 == 'G' ? (return true) : (return false)

    else
        nt2 == 'C' ? (return true) : (return false)
    end
end

#main function. solution assumes at least 1 transversion and same lengths.
function ratio(seq1::String,seq2::String)
    transi, transv = 0,0
    for i in 1:length(seq1)
        if seq1[i] != seq2[i]
            if is_transition(seq1[i],seq2[i])
                transi += 1
            else
                transv += 1
            end
        end
    end
    return transi/transv
end

#I/O
seqs = get_seqs(readlines("inputs/rosalind_tran.txt"))
println(ratio(seqs[1], seqs[2])) #1.9906542056074767