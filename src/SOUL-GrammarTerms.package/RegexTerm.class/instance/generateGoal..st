private
generateGoal: aCollection
	
	| generated |
	generated := RegexGoal
		newWith: aCollection
		id: RegexTerm nrGeneratedGoals
		variables: (self getVariables).
	generatedGoals add: generated.
	RegexTerm incNrGeneratedGoals.
	^generated