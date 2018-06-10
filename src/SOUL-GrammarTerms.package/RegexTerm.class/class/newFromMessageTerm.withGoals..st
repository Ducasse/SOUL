instance creation
newFromMessageTerm: aMessageTerm withGoals: goals
	
	| term |
	term := RegexTerm
		functor: aMessageTerm functor
		termSequence: aMessageTerm termSequence
		astLink: aMessageTerm astLink.
	term validateRegexTerms.
	term goals: goals.
	^term