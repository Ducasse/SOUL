generated
scanForTokenX7
	self recordMatch: #(12).
	self step.
	currentCharacter == $>
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	^ self reportLastMatch