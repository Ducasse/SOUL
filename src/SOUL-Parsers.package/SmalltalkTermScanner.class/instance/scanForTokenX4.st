generated
scanForTokenX4
	self recordMatch: #(20 34).
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan3 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan4 ].
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ [ self recordMatch: #(20).
			self step.
			currentCharacter == $.
				ifTrue: [ ^ self scan3 ].
			currentCharacter == $:
				ifTrue: [ ^ self scan4 ].
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
				whileTrue ].
	^ self reportLastMatch