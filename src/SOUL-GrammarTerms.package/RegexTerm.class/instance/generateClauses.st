converting
generateClauses
	
	RegexTerm resetGeneratedClauses.
	generatedGoals
		do:
			[:goal | goal generateTransitions: self term: (self getEdgeTerm) definitionRepository: nil].
	self isExistential ifTrue: [self generateExistential: nil].
	self isUniversal ifTrue: [self generateUniversal: nil].
	generatedClauses := RegexTerm generatedClauses