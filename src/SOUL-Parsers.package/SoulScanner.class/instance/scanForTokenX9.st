generated
scanForTokenX9
	currentCharacter == $@
		ifTrue:
			[ ^ self scanForTokenX8 ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(28) ].
	currentCharacter == $|
		ifTrue: [ ^ self recordAndReportMatch: #(11) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue:
			[ ^ self scanForTokenX6 ].
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			currentCharacter == $:
				ifTrue: [ ^ self recordAndReportMatch: #(19) ].
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch