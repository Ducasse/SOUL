initialize-release
validateRegexTerms
	|size|
	size := self termSequence terms first termSequence terms size.
	((5 to: 5) includes: size)
		ifFalse:
			[self error:
					'goalTerm needs to have 5 arguments: transition, startworld, endworld, variables and a pathvariable'].