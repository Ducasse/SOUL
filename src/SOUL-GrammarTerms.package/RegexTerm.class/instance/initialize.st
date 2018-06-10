initialize-release
initialize
	
	super initialize.
	identifier := RegexTerm addRegexTerm.
	generatedGoals := OrderedCollection new