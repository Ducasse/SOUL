generated
scanForTokenX10
	currentCharacter == $&
		ifTrue:
			[ ^ self scanForTokenX4 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $+
		ifTrue:
			[ ^ self scanForTokenX3 ].
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter == $-
		ifTrue:
			[ ^ self scanForTokenX1 ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	currentCharacter == $:
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $<
		ifTrue:
			[ ^ self scanForTokenX7 ].
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter == $>
		ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	currentCharacter == $?
		ifTrue:
			[ ^ self scanForTokenX2 ].
	^ self scanForTokenX9