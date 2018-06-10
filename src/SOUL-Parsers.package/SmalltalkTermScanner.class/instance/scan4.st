generated
scan4
	self recordMatch: #(24).
	self step.
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(31) ].
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch