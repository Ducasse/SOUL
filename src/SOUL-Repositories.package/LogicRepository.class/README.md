LogicRepository represents a database of logic clauses that can be used by the Soul interpreter. It supports adding clauses from layers as well as adding new clauses that are not saved in a layer. 

Normally, the interpreter fetches the clauses by lexical address. This can be done because a repository can 'compile' his clauses to make repository access faster. Compilation of the repository simply means that all predicates in the repository are given a unique address, at which they can be found in the repository. The interpreter can thus easily and quickly access all necessary clauses.

Repositories can also be composed through repository variables. These are variables that can be used in Soul's callterms (e.g. ?var->pred(a) ). 
TODO: we must find a way to unify these variables with normal variables occuring in the rest of the program.

