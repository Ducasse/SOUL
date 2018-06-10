generated
scanForTokenX10
	self recordMatch: #(18 34).
	self step.
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	^ self reportLastMatch