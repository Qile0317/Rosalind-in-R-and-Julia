GENERAL
- many fasta processing functions require stitching, even though there can be more memory efficient ways to avoid doing that
- learn modulo trick

splc
- running all comparisons in 1 run. O(mn)
- accounting for overlap
- use of suffix tree
- burrows-wheeler transform

cons
- sequence consensus is technically an unsolved problem. (https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-8-S7-S21) 
  the implemented algorithm is the most basic brute force algorithm that has exponential time complexity though with 100% accuracy. 

mprt
- The matching algorithm is O(mn) where m is the length of the motif, not sure if theres any faster way to do it.

grph
- The algo used was pretty much brute force O(n^2), and I think this might be related to de bruijn graphs which could make it faster. 
- something with on-the-go hashing should be able to make it O(n). for every new barcode it would be able to hash back and a variable for whether its been done alr.

revp 
- The algo used was pure brute force O(n^3), but the dynamic programming approach can be O(n^2) if a dp truth matrix is created and iterated over. 
- Otherwise its very related to manachers algorithm (longest palindromic substr problem)

iprb
- need to re-work the maths

perm
- implement my own version of heap's algo instead

pdst
- only half of the distances need to be computed, but the approach i did just simply computed them all in place.
- The simple way to do so is to keep a dict of tuple:float where each tuple is `(j, i) => pd(seq[i],seq[j])` so that when the new i and j gets to there, one first checks if its there and then the dist wont have to be recomputed.

mmch
- didn't completely understand how the combinatorical solution was arrived at, similar to another previous problem

orf
- super inefficient in terms of memory and speed though technically O(n). 
- theres an extremely sus fix for a bug in the code where some AAs that DONT start with "M" are added...