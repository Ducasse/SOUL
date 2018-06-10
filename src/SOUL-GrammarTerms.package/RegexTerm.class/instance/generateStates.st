converting
generateStates
	
	| firstlast end |
	firstlast := self generateGoals: goals termSequence terms.
	initialGoal := firstlast at: 1.
	end := firstlast at: 2.
	endGoal := self generateGoal: OrderedCollection new.
	self connect: end to: endGoal class: RegexEndTransition.
	self fixTermMagic.
	self generateClauses