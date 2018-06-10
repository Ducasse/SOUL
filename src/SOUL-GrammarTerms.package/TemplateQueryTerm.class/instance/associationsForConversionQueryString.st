private
associationsForConversionQueryString
	
	| arguments associations |
	arguments := self type termSequence terms.
	self hasInterpretationArgument
		ifFalse:
			[arguments size = 1
				ifTrue: [associations := Array with: #resultTerm -> arguments first]
				ifFalse: [self error: 'incorrect amount of arguments']]
		ifTrue:
			[arguments size = 2
				ifTrue:
					[associations := Array
						with: #resultTerm -> arguments first
						with: #interpretationTerm -> (arguments at: 2)]
				ifFalse: [self error: 'incorrect amount of arguments']].
	^associations