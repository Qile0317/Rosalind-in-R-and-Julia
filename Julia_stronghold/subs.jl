#most direct comparison approach (likely not the most efficient)

function subs(dna::String ,query::String)
    windowsize, loci = length(query), ""
    for i in 1:length(dna)-windowsize+1
        if view(dna, i:i+windowsize-1) == query
            loci *= string(i)*" "
        end
    end
    return println(loci)
end

subs("TGGCTGACCTAGGACCTAGGTAAACCACAGACCTAGGACCTAGGACCTAGATACGACCTAGGGACCTAGCGCGACCTAGGGACCTAGGGACCTAGGCAGAGACCTAGGACCTAGGACCTAGTGGAGACCTAGTAACGACCTAGGGACCTAGTGACCTAGCGACCTAGTTGACCTAGGACCTAGGGACCTAGGACCTAGATAGCGTCCACCGACCTAGGAACAAAAGACCTAGTATCGAGTCCGACCTAGTAACTCGACCTAGAAGGACCTAGGACCTAGTTCCTGACCTAGAAAGACGGACCTAGTCGACCTAGTGACCTAGAATCGGCGCTTCAATTGACCTAGTCGACCTAGGACCTAGATGGACCTAGAGAAGACCTAGTTAGACCTAGGGCAGACCTAGAGCGACCTAGCTGTCTGGGCAGACCTAGACCGACCTAGGACCTAGTAGACCTAGGGACCTAGGACCTAGGTGACCTAGGACCTAGGACCTAGTTAGTGACCTAGGACCTAGGACGACCTAGGACCTAGGGAAGACCTAGGGACCTAGAGACCTAGTGGGACCTAGCGACCTAGAGTAGGGACCTAGGCCGGTAGATCCAGACCTAGGAGGACCTAGAGACCTAGGACCTAGCTCGGACCTAGACGTGACCTAGTGACCTAGGCGGGACCTAGCCGACCTAGGGACCTAGTCTCCGACCTAGGCGGATAGGACCTAGCCACAGGTTGCCGACCTAGTGACCTAGGACCTAGTTAAGACCTAGCGACCTAGCTCGTTTCCCTTGCGACCTAGTGTCTAGACCTAGGGGACCTAGGGACCTAGAGCAGCGATGACCTAGTCTGTATACTTGACCTAGGGGACCTAGTCAATGACCTAGATAGGACCTAGCTGGACCTAGCTCAGACCTAGCTGGATAGGGGACCTAGGACCTAGCTGGACCTAGAGGTCCGACCTAG",
"GACCTAGGA")