public-enumerating
doCollection: aBlock forVariableNames: aCollectionOfVariableNames
	"Enumerate over the results but only consider the results of some  
	variables. aBlock is a smalltalkblock that must have 1 parameter, which will be bound to a collection of values for the variables named"

	
	self
		doCollection: aBlock
		forVariables:
			(aCollectionOfVariableNames
				collect:
					[:each | 
					| temp |
					results keys do: [:key | key name = each ifTrue: [temp := key]].
					temp])