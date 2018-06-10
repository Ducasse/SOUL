generated
scanForTokenX4
	self recordMatch: #(1).
	self step.
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(23).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch