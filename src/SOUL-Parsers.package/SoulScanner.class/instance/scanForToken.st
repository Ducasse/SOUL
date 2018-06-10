generated
scanForToken
	self step.
	currentCharacter == $!
		ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	currentCharacter == $"
		ifTrue: [ [ self step.
			currentCharacter == $"
				ifTrue: [ ^ self recordAndReportMatch: #(30) ].
			true ] whileTrue ].
	currentCharacter == $#
		ifTrue:
			[ ^ self scanForTokenX5 ].
	^ self scanForTokenX10