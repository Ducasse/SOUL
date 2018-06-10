access
usesPredicate: aPredicate multiplicity: aNumber
	"See comment in AbstractTerm"

	
	self name isString
		ifTrue: [^self predicate = aPredicate & (self multiplicity = aNumber)].
	^false