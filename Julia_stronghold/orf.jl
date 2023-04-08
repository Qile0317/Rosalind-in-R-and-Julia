# super inefficient in terms of memory and speed though technically O(n). 
# So this version is memory inefficient AF and requires multiple temporary arrays and iterations of indicies
# also theres an extremely sus fix for a bug in the code where some AAs that DONT start with "M" are added...

# dependencies
const dna_codon_table= Dict("TTT" => "F", "TTC" => "F", "TTA" => "L", "TTG" => "L",
                            "CTT" => "L", "CTC" => "L", "CTA" => "L", "CTG" => "L",
                            "ATT" => "I", "ATC" => "I", "ATA" => "I", "ATG" => "M",
                            "GTT" => "V", "GTC" => "V", "GTA" => "V", "GTG" => "V",
                            "TCT" => "S", "TCC" => "S", "TCA" => "S", "TCG" => "S",
                            "CCT" => "P", "CCC" => "P", "CCA" => "P", "CCG" => "P",
                            "ACT" => "T", "ACC" => "T", "ACA" => "T", "ACG" => "T",
                            "GCT" => "A", "GCC" => "A", "GCA" => "A", "GCG" => "A",
                            "TAT" => "Y", "TAC" => "Y", "TAA" => "STOP",   "TAG" => "STOP",
                            "CAT" => "H", "CAC" => "H", "CAA" => "Q", "CAG" => "Q",
                            "AAT" => "N", "AAC" => "N", "AAA" => "K", "AAG" => "K",
                            "GAT" => "D", "GAC" => "D", "GAA" => "E", "GAG" => "E",
                            "TGT" => "C", "TGC" => "C", "TGA" => "STOP",   "TGG" => "W",
                            "CGT" => "R", "CGC" => "R", "CGA" => "R", "CGG" => "R",
                            "AGT" => "S", "AGC" => "S", "AGA" => "R", "AGG" => "R",
                            "AGT" => "S", "AGC" => "S", "AGA" => "R", "AGG" => "R",
                            "GGT" => "G", "GGC" => "G", "GGA" => "G", "GGG" => "G")

function stitch(seqs::Vector{String})  # take [2:end] of input fasta file
    output = ""
    for seq in seqs; output *= seq end
    return output
end

function revc(seq::String)
    revcomp_dict = Dict{Char,String}('A'=>"T",'T'=>"A",'G'=>"C",'C'=>"G")
    revcomp = ""
    for nt in seq; revcomp = revcomp_dict[nt] * revcomp end
    return revcomp
end

# translate single sequence
function translate(dna::String)
    aa = ""
    for i in 1:3:length(dna)
        aa *= dna_codon_table[dna[i:i+2]]
    end
    return aa
end

#for readability:
is_stop_codon(aa::Any) = aa == "STOP"
is_start_codon(aa::Any) = aa == "M"

function push_aas!(vec::Vector{String}, orf_aa::String, inds::Vector{Int})
    push!(vec, orf_aa)
    for ind in inds
        push!(vec, orf_aa[ind:end])
    end
end

# for single seq - could be bit based
function get_aas(seq::String, n::Int)
    not_in_orf = true
    curr_orf_aa, curr_m_vec = "", Int[]
    aa_ind = 1
    aa_vec = String[]

    for i in 1:3:n-2
        curr_aa = dna_codon_table[seq[i:i+2]]
        if not_in_orf
            if is_start_codon(curr_aa)
                curr_orf_aa = "M"
                not_in_orf = false
                aa_ind = 1
            end
        else
            aa_ind += 1
            if is_start_codon(curr_aa)
                push!(curr_m_vec, aa_ind)
                curr_orf_aa *= curr_aa
            elseif is_stop_codon(curr_aa)
                not_in_orf = true
                push_aas!(aa_vec, curr_orf_aa, curr_m_vec)
                # no need to reset curr_orf_aa yet
            else
                curr_orf_aa *= curr_aa
            end
        end
    end
    return aa_vec
end

# do the procedure for 3 reading frames and revcomp.
# more optimally seqs are appended to the str, here theres first a vec then append
function orf(seq::String)
    output = ""
    n = length(seq)
    aa_set = Set(String[])
    for start_ind in 1:3
        for aa in get_aas(seq[start_ind:end], n - start_ind + 1)
            if !(aa in aa_set) && aa != "" && aa[1] == 'M'
                output *= aa*"\n"
                push!(aa_set, aa)
            end
        end
    end
    revcomp_seq = revc(seq)
    for start_ind in 1:3
        for aa in get_aas(revcomp_seq[start_ind:end], n - start_ind + 1)
            if !(aa in aa_set) && aa != "" && aa[1] == 'M'
                output *= aa*"\n"
                push!(aa_set, aa)
            end
        end
    end
    return output[1:end-1]
end

# I/O
seq = stitch(readlines("inputs/rosalind_orf.txt")[2:end])
open("outputs/orf.txt", "w") do io
    write(io, orf(seq))
end