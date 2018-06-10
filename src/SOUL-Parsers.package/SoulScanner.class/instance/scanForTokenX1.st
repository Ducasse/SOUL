generated
scanForTokenX1
	self step.
	currentCharacter == $-
		ifTrue: [ self step.
			currentCharacter == $>
				ifTrue: [ ^ self recordAndReportMatch: #(29) ].
			^ self reportLastMatch ].
	currentCharacter == $>
		ifTrue: [ ^ self recordAndReportMatch: #(15) ].
	currentCharacter == $?
		ifTrue: [ self step.
			((currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ [ self recordMatch: #(25).
					self step.
					(currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ] ].
	^ self reportLastMatch