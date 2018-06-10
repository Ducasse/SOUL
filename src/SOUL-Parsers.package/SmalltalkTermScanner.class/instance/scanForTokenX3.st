generated
scanForTokenX3
	self recordMatch: #(26 34).
	self step.
	(currentCharacter between: $0 and: $9)
		ifTrue: [ ^ self recordAndReportMatch: #(22) ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	^ self reportLastMatch