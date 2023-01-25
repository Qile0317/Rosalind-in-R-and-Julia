function hamm(seq1,seq2)
    distance = 0
    for i in 1:length(seq1)
        if seq1[i] != seq2[i]; distance += 1 end
    end
    return println(distance)
end

#I/O 
input = readlines("inputs/rosalind_hamm.txt")
hamm(input[1],input[2]) #450