private
clausesAt: anAddress multiplicity: aMultiplicity
	
	| multIndex multArray |
	"return all clauses at the address for the given multiplicity"

	multIndex := aMultiplicity + 2.
	multArray := clauseArray at: anAddress.
	multArray == nil ifTrue: [^OrderedCollection new].
	^multIndex > multArray size
		ifTrue: [OrderedCollection new]
		ifFalse: [multArray at: multIndex]