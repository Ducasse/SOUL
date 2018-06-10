access
usesPredicate: aPredicate multiplicity: aNumber
	"This method is used by repositories to look up all predicated used inside a clause."

	
	(self functor isKindOf: Variable)
		ifFalse:
			[self predicate = aPredicate & (self multiplicity = aNumber)
				ifTrue: [^true]].
	^self termSequence usesPredicate: aPredicate multiplicity: aNumber