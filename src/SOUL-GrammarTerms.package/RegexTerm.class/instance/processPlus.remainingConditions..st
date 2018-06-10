private
processPlus: plusTerm remainingConditions: aCollection
	
	| firstLast first last remainingGoals |
	firstLast := self generateGoals: plusTerm termSequence terms.
	firstLast ifNil: [self error: 'plusTerm with empty arguments'].
	remainingGoals := self processManyOf: plusTerm remainingConditions:
			aCollection.
	first := firstLast at: 1.
	last := firstLast at: 2.
	remainingGoals isNil
		ifFalse:
			[self
				connect: (firstLast at: 2)
				to: (remainingGoals at: 1)
				class: RegexTransition.
			last := remainingGoals at: 2].
	^Array with: first with: last