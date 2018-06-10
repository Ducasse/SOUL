public-enumerating
do: aBlock forVariableNames: aCollectionOfVariableNames
	"Enumerate over the results but only consider the results of some  
	variables. aBlock is a smalltalkblock that must have as many  
	parameters as the number of variables. The parameters will be bound  
	to a their value, for each subsequent result"

	
	self
		do: aBlock
		forVariables:
			(aCollectionOfVariableNames
				collect:
					[:each | 
					| temp |
					results keys do: [:key | key name = each ifTrue: [temp := key]].
					temp])