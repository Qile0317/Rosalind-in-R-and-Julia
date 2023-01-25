library(hash)

# creating my own hashing syntax,
# though might be better to just let it take a list instead
Dict <- function(keys, values){
    output <- hash()
    for (i in 1:length(keys)){
        output[[keys[i]]] <- values[i]
    }
    return(output)
}

nt_dict <- Dict(c("A", "C", "G", "T"), c(1, 2, 3, 4))

ini <- function(seq){
    output <- c(0, 0, 0, 0)
    for (i in 1:nchar(seq)) {
        nt <- substring(seq, i, i)
        output[nt_dict[[nt]]] <- output[nt_dict[[nt]]] + 1
    }
    return(output)
}

#I/O
input <- readLines("inputs/rosalind_ini.txt")
print(ini(input)) # 205 212 204 233