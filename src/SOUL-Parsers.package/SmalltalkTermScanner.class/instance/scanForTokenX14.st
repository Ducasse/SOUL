generated
scanForTokenX14
	currentCharacter == $|
		ifTrue:
			[ ^ self scanForTokenX5 ].
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(8 34) ].
	(currentCharacter between: $0 and: $9)
		ifTrue: [ ^ self recordAndReportMatch: #(21 34) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue:
			[ ^ self scanForTokenX8 ].
	currentCharacter isSafeForHTTP
		ifTrue:
			[ ^ self scanForTokenX4 ].
	(currentCharacter isArrow
		or: [ currentCharacter <= Character backspace
				or: [ (currentCharacter
						between: (Character value: 14)
						and: Character escape)
						or: [ currentCharacter == $`
								or: [ currentCharacter >= (Character value: 127) ] ] ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(34) ].
	^ self scanForTokenX13