function translate(rna::String)
    # Define a dictionary of RNA codons and their corresponding amino acids
    codon_table = Dict("UUU" => "F", "UUC" => "F", "UUA" => "L", "UUG" => "L",
                       "UCU" => "S", "UCC" => "S", "UCA" => "S", "UCG" => "S",
                       "UAU" => "Y", "UAC" => "Y", "UAA" => "", "UAG" => "",
                       "UGU" => "C", "UGC" => "C", "UGA" => "", "UGG" => "W",
                       "CUU" => "L", "CUC" => "L", "CUA" => "L", "CUG" => "L",
                       "CCU" => "P", "CCC" => "P", "CCA" => "P", "CCG" => "P",
                       "CAU" => "H", "CAC" => "H", "CAA" => "Q", "CAG" => "Q",
                       "CGU" => "R", "CGC" => "R", "CGA" => "R", "CGG" => "R",
                       "AUU" => "I", "AUC" => "I", "AUA" => "I", "AUG" => "M",
                       "ACU" => "T", "ACC" => "T", "ACA" => "T", "ACG" => "T",
                       "AAU" => "N", "AAC" => "N", "AAA" => "K", "AAG" => "K",
                       "AGU" => "S", "AGC" => "S", "AGA" => "R", "AGG" => "R",
                       "GUU" => "V", "GUC" => "V", "GUA" => "V", "GUG" => "V",
                       "GCU" => "A", "GCC" => "A", "GCA" => "A", "GCG" => "A",
                       "GAU" => "D", "GAC" => "D", "GAA" => "E", "GAG" => "E",
                       "GGU" => "G", "GGC" => "G", "GGA" => "G", "GGG" => "G")

    protein = ""
    # Iterate over the RNA string in 3-letter chunks (codons)
    for i in 1:3:length(rna)-2
        codon = rna[i:i+2]
        amino_acid = codon_table[codon]
        protein *= amino_acid
    end
    return println(protein)
end

#I/O 
rna = readline("inputs/rosalind_prot.txt")
translate(rna)
