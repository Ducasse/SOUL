generated
scanForToken
	self step.
	currentCharacter == Character space
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $'
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $?
		ifTrue: [ self step.
			((currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ [ self recordMatch: #(3).
					self step.
					(currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $@
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $\
		ifTrue: [ self step.
			((currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ [ self recordMatch: #(4).
					self step.
					(currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
			^ self reportLastMatch ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue: [ ^ self recordAndReportMatch: #(1 2) ].
	^ self recordAndReportMatch: #(1)