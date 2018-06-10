private
clausesAt: anAddress multiplicity: aMultiplicity put: aCollection
	
	| multIndex multArray |
	"set a collection of clauses at the address for the given multiplicity"

	multIndex := aMultiplicity + 2.
	multArray := clauseArray at: anAddress.
	multArray == nil
		ifTrue:
			[multArray := Array new: 20.
			(1 to: multArray size)
				do:
					[:i | 
					multArray
						at: i
						put: OrderedCollection new].
			clauseArray at: anAddress put: multArray].	"TODO: allow the multiplicity to go over 18"

	^multIndex > multArray size
		ifTrue:
			[self halt:
					'This has not been implemented yet. Try making shorter predicates']
		ifFalse: [multArray at: multIndex put: aCollection]