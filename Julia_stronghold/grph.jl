# this approach is O(n^2), but I think a version with a hashtable that is continually filled can be O(n)
# it can also be generalized to O_k

mutable struct node
    id::String
    pref::String
    suff::String
    neighbours::Vector{String}

    # initialization
    node(fasta_id::String) = new(fasta_id, "", "", String[])
end

# FASTA file processor, the first one is just for readability
is_identifier(line::String) = line[1] == '>'

function construct_nodes(fasta_file::Vector{String})
    n = length(fasta_file)
    node_vec, node_count, line_count = node[], 0, 0
    for i in 1:n
        line = fasta_file[i]
        if is_identifier(line)
            node_count += 1
            line_count = 0
            if i != 1; node_vec[node_count-1].suff = fasta_file[i-1][end-2:end] end
            push!(node_vec, node(line[2:end]))
        else
            line_count += 1
            if line_count == 1
                node_vec[node_count].pref = line[1:3] # some indexing error
            end
            if i == n # last line
                node_vec[node_count].suff = line[end-2:end]
            end
        end
    end
    return node_vec
end

# quadratic algo to find matches in an adj_list
function match!(node_vec::Vector{node})
    for i in 1:length(node_vec)
        for j in 1:length(node_vec)
            if i != j
                if node_vec[i].suff == node_vec[j].pref
                    push!(node_vec[i].neighbours, node_vec[j].id)
                end
            end
        end
    end
end

match!(testing)

# stitching
function stitch(node_vec::Vector{node})
    output = ""
    for curr_node in node_vec
        if !isempty(curr_node.neighbours)
            for seq_id in curr_node.neighbours
                output *= curr_node.id*" "*seq_id*"\n"
            end
        end
    end
    return output[1:end-1]
end

# API
function grph(fasta_file::Vector{String})
    node_vector = construct_nodes(fasta_file)
    match!(node_vector)
    return stitch(node_vector)
end

#I/O
input = readlines("inputs/rosalind_grph.txt")
open("outputs/grph.txt", "w") do io
    write(io, grph(input))
end

"""
#this approaches uses hash table construction of pre and suffixes, then scanning through both
function tables(fasta_file::Vector{String},thr=3)
    #dict construction: O(n)
    prefix_dict, suffix_dict = Dict{String,Vector{String}}(), Dict{String,Vector{String}}()
    seq_count = 0
    push!(fasta_file,">extra identifier")
    for i in 2:length(fasta_file)-1
        prev_line = fasta_file[i-1]

        #get prefix
        if is_identifier(prev_line) 
            curr_identifier = prev_line[2:end] 
            curr_prefix = fasta_file[i][1:thr]
            if get(prefix_dict,curr_prefix,"no match") == "no match"
                prefix_dict[curr_prefix] = String[curr_identifier]
            else
                push!(prefix_dict[curr_prefix],curr_identifier) #not sure if it works
            end
        end

        #get suffix
        if is_identifier(fasta_file[i+1]) 
            curr_suffix = fasta_file[i][end-thr+1:end]
            if get(suffix_dict,curr_suffix,"no match") == "no match"
                suffix_dict[curr_suffix] = String[curr_identifier]
            else
                push!(suffix_dict[curr_suffix],curr_identifier)
            end
        end
    end
    return prefix_dict, suffix_dict
end

#works. 

#go through the two hash tables and try to match (UNFINISHED)
function match(prefix_dict::Dict{String,Vector{String}}, suffix_dict::Dict{String,Vector{String}})
    output = ""
    for kv in prefix_dict 
        curr_prefix = first(kv)
        search = get(suffix_dict,curr_prefix,"no match")
        if search != "no match"
            for id in search #actually hashmap might work again here bc now its quadratic time complexity though with average linear complexity
            end
        end
"""