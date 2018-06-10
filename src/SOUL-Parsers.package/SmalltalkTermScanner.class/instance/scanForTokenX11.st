generated
scanForTokenX11
	self recordMatch: #(34).
	self step.
	currentCharacter == $'
		ifTrue: [ ^ self scan2 ].
	^ self scan1