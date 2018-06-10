private
processManyOf: manyTerm remainingConditions: aCollection
	
	| firstLast first last remainingGoals |
	firstLast := self generateGoals: manyTerm termSequence terms.
	firstLast ifNil: [self error: 'manyOf with empty arguments'].
	first := firstLast at: 1.
	last := firstLast at: 2.
	self connect: last to: first class: RegexTransition.
	remainingGoals := self generateGoals: aCollection.
	remainingGoals isNil
		ifFalse:
			[self
				connect: first
				to: (remainingGoals at: 1)
				class: RegexEpsilonTransition.
			last := remainingGoals at: 2]
		ifTrue: [last := first].
	^Array with: first with: last