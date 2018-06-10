generated
scanForTokenX9
	self recordMatch: #(34).
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self recordAndReportMatch: #(28) ].
	true
		ifTrue: [ [ self step.
			currentCharacter == $"
				ifTrue: [ ^ self recordAndReportMatch: #(28) ].
			true ] whileTrue ].
	^ self reportLastMatch