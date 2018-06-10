private
processOr: orTerm remainingConditions: aCollection
	
	| start end newGoals remainingGoals |
	newGoals := OrderedCollection new.
	orTerm termSequence terms
		do:
			[:termSequence | newGoals add: (self generateGoals: termSequence terms)].
	start := self generateGoal: OrderedCollection new.
	end := self generateGoal: OrderedCollection new.
	newGoals
		do:
			[:firstLast | 
			self
				connect: start
				to: (firstLast at: 1)
				class: RegexEpsilonTransition.
			self
				connect: (firstLast at: 2)
				to: end
				class: RegexEpsilonTransition].
	remainingGoals := self generateGoals: aCollection.
	remainingGoals isNil
		ifFalse:
			[self
				connect: end
				to: (remainingGoals at: 1)
				class: RegexTransition.
			end := remainingGoals at: 2].
	^Array with: start with: end