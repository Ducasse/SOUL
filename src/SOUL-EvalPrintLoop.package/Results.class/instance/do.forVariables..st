public-enumerating
do: aBlock forVariables: aCollectionOfVariables
	"Enumerate over the results but only consider the results of some  
	variables. aBlock is a smalltalkblock that must have as many  
	parameters as the number of variables. The parameters will be bound  
	to a their value, for each subsequent result"

	
	1
		to: self size
		do:
			[:index | 
			aBlock
				valueWithArguments:
					(aCollectionOfVariables collect: [:var | (results at: var) at: index])
						asArray]