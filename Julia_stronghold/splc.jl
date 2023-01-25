function translate(dna::String)
    dna_codon_table = Dict("TTT" => "F", "TTC" => "F", "TTA" => "L", "TTG" => "L",
                           "CTT" => "L", "CTC" => "L", "CTA" => "L", "CTG" => "L",
                           "ATT" => "I", "ATC" => "I", "ATA" => "I", "ATG" => "M",
                           "GTT" => "V", "GTC" => "V", "GTA" => "V", "GTG" => "V",
                           "TCT" => "S", "TCC" => "S", "TCA" => "S", "TCG" => "S",
                           "CCT" => "P", "CCC" => "P", "CCA" => "P", "CCG" => "P",
                           "ACT" => "T", "ACC" => "T", "ACA" => "T", "ACG" => "T",
                           "GCT" => "A", "GCC" => "A", "GCA" => "A", "GCG" => "A",
                           "TAT" => "Y", "TAC" => "Y", "TAA" => 0, "TAG" => 0,
                           "CAT" => "H", "CAC" => "H", "CAA" => "Q", "CAG" => "Q",
                           "AAT" => "N", "AAC" => "N", "AAA" => "K", "AAG" => "K",
                           "GAT" => "D", "GAC" => "D", "GAA" => "E", "GAG" => "E",
                           "TGT" => "C", "TGC" => "C", "TGA" => 0, "TGG" => "W",
                           "CGT" => "R", "CGC" => "R", "CGA" => "R", "CGG" => "R",
                           "AGT" => "S", "AGC" => "S", "AGA" => "R", "AGG" => "R",
                           "AGT" => "S", "AGC" => "S", "AGA" => "R", "AGG" => "R",
                           "GGT" => "G", "GGC" => "G", "GGA" => "G", "GGG" => "G")
    protein = ""
    for i in 1:3:length(dna)-2
        aa = dna_codon_table[dna[i:i+2]]
        if aa == 0
            break
        end
        protein *= aa
    end
    return println(protein)
end

function is_sequence(line::String)
    return '>' != line[1]
end

function splice(input::Vector{String})
    identifier::Int64, dna::String = 0, ""
    for i in 1:length(input)
        line = input[i]
        if is_sequence(line)
            if identifier > 1
                dna = replace(dna, line => "") #lazy solution, it could be improved by scanning multiple or using BioSequences.jl
            else
                dna *= line
            end
        else
            identifier += 1
        end
    end
    return translate(dna)
end

#I/O 
splice(readlines("inputs/rosalind_splc.txt"))