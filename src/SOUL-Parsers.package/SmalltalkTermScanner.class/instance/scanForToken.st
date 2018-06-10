generated
scanForToken
	self step.
	currentCharacter == $"
		ifTrue:
			[ ^ self scanForTokenX9 ].
	currentCharacter == $#
		ifTrue: [ ^ self recordAndReportMatch: #(1 34) ].
	currentCharacter == $$
		ifTrue:
			[ ^ self scanForTokenX12 ].
	currentCharacter == $&
		ifTrue:
			[ ^ self scanForTokenX2 ].
	currentCharacter == $'
		ifTrue:
			[ ^ self scanForTokenX11 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(10 34) ].
	^ self scanForTokenX15