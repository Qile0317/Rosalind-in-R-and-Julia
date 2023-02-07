function tree(input)
    n = parse(Int64, input[1])
    m = length(input) - 1 
    return n - 1 - m
end

# I/O
input = readlines("inputs/rosalind_tree.txt")
tree(input) # 53