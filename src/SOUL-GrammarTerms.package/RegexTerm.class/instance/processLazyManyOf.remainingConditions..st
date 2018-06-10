private
processLazyManyOf: manyTerm remainingConditions: aCollection
	
	| firstLast first last regexLast remainingGoals |
	firstLast := self generateGoals: manyTerm termSequence terms.
	firstLast ifNil: [self error: 'manyOf with empty arguments'].
	first := firstLast at: 1.
	last := firstLast at: 2.
	regexLast := last.
	remainingGoals := self generateGoals: aCollection.
	remainingGoals isNil
		ifFalse:
			[self
				connect: first
				to: (remainingGoals at: 1)
				class: RegexEpsilonTransition.
			last := remainingGoals at: 2]
		ifTrue: [last := first].
	self connect: regexLast to: first class: RegexTransition.
	^Array with: first with: last