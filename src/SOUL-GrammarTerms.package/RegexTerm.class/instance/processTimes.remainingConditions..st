private
processTimes: timesTerm remainingConditions: aCollection
	
	| times firstLast first last remainingGoals terms timesTerms |
	terms := timesTerm termSequence terms.
	terms size < 2
		ifTrue:
			[self error: 'times term requires at least 2 arguments, times and goals'].
	times := (terms at: 1) smalltalkValue.
	timesTerms := terms allButFirst: 1.
	firstLast := self generateGoals: timesTerms.
	first := firstLast at: 1.
	last := firstLast at: 2.
	2
		to: times
		do:
			[:i | 
			| generated |
			generated := self generateGoals: timesTerms.
			self
				connect: last
				to: (generated at: 1)
				class: RegexTransition.
			last := generated at: 2].
	remainingGoals := self generateGoals: aCollection.
	remainingGoals isNil
		ifFalse:
			[self
				connect: last
				to: (remainingGoals at: 1)
				class: RegexTransition.
			last := remainingGoals at: 2].
	^Array with: first with: last