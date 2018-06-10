building SOUL
buildCallTerm: aTerm variable: aVariable
	"I made a mistake in the parser generation... the actual arguments that are passed are switched with respect to the keywords..."

	
	^SoulFactory current makeCallTerm variable: aVariable term: aTerm