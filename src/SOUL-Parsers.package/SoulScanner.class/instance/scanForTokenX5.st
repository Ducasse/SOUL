generated
scanForTokenX5
	self step.
	((currentCharacter between: $0 and: $:)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(20).
			self step.
			(currentCharacter between: $0 and: $:)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch