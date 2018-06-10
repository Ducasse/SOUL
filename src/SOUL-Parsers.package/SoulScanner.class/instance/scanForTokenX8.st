generated
scanForTokenX8
	self step.
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	^ self reportLastMatch