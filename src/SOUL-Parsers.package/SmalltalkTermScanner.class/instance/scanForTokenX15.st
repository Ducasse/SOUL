generated
scanForTokenX15
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(4 34) ].
	currentCharacter == $-
		ifTrue:
			[ ^ self scanForTokenX3 ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(5 34) ].
	currentCharacter == $:
		ifTrue:
			[ ^ self scanForTokenX10 ].
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(2 34) ].
	currentCharacter == $<
		ifTrue:
			[ ^ self scanForTokenX7 ].
	currentCharacter == $>
		ifTrue:
			[ ^ self scanForTokenX6 ].
	currentCharacter == $?
		ifTrue:
			[ ^ self scanForTokenX1 ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(17 34) ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(19 34) ].
	currentCharacter == $^
		ifTrue: [ ^ self recordAndReportMatch: #(16 34) ].
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(3 34) ].
	^ self scanForTokenX14