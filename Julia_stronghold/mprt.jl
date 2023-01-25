using HTTP

#retrieving fasta entry as string, accounting for redirection
function get_file(id::String)
    request = HTTP.get("https://rest.uniprot.org/uniprotkb/"*id[1:6]*".fasta"; status_exception = false)
    if request.body != []
        return String(request.body)
    end 
    #handling redirection
    newsite = HTTP.get("https://rest.uniprot.org"*request.headers[12][2])
    return String(newsite.body)
end

#kmer matching (N-glycosylation) = N{P}[ST]{P}
function is_match(kmer)
    if kmer[1] != 'N'; return false end #N
    if kmer[2] == 'P'; return false end #{P}
    if kmer[3] != 'S' && kmer[3] != 'T'; return false end #[ST]
    if kmer[4] == 'P'; return false end #{P}
    return true 
end

#get the aa sequence itself and stitch it into 1 string. 
function get_sequence(fasta_entry::String)
    n_count, actual_seq = 0, ""
    for i in 1:length(fasta_entry)-1
        if view(fasta_entry,i:i) == "\n"
            n_count += 1 
            if n_count == 1
                actual_seq = fasta_entry[i+1:end]
            end
        end
    end
    return replace(actual_seq, "\n" => "")
end

#find matches based on a single fasta entry of the query and returns the string of match locations separated by a space, ending in \n. 
function return_matches(fasta_entry::String)
    match_str = ""
    aastr = get_sequence(fasta_entry)
    for i in 1:length(aastr)-3
        kmer = view(aastr,i:i+3)
        if is_match(kmer)
            #println(kmer) #for debugging
            match_str *= string(i)*" "
        end
    end
    if match_str == ""
        return "no match"
    else
        return match_str*"\n"
    end
end

#main function to return what the task requires 
function mprt(IDs::Vector{String})
    output = ""
    for id in IDs
        println(id)
        match_result = return_matches(get_file(id))
        if match_result != "no match"
            output *= id*"\n"*match_result
        end
    end
    return output
end

#I/O
IDs = readlines("inputs/rosalind_mprt.txt")
open("outputs/mprt.txt","w") do io
    write(io,mprt(IDs))
end