#mod 1 million is basically just truncating the result to the last 6 digits.

codon_counts = Dict{Char,Int}('F' => 2, 'L' => 6, 'S' => 6, 'Y' => 2, 'C' => 2, 
'W' => 1, 'P' => 4, 'H' => 2, 'Q' => 2, 'R' => 6, 'I' => 3, 'M' => 1, 'T' => 4, 
'N' => 2, 'K' => 2, 'V' => 4, 'A' => 4, 'D' => 2, 'E' => 2, 'G' => 4) #excludes stop codon which has 3 mrnas. 

function mrna(protein::String)
    modulo = 1000000
    num_codons = 1 #ignore start codon
    for aa in protein
        num_codons *= codon_counts[aa]
        num_codons %= modulo
    end
    return println(num_codons*3 % modulo) #account for stop codon
end

inp = readline("inputs/rosalind_mrna.txt")
mrna(inp) #34624