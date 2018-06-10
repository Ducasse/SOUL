public-enumerating
doCollection: aBlock forVariables: aCollectionOfVariables
	"Enumerate over the results but only consider the results of some  
	variables. aBlock is a smalltalkblock that must have 1 paramater. The parameter will be bound  
	to a collection of values for the variables"

	
	1
		to: self size
		do:
			[:index | 
			aBlock
				value:
					(aCollectionOfVariables collect: [:var | (results at: var) at: index])
						asArray]