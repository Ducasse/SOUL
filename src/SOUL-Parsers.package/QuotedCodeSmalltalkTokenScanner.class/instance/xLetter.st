multi-character scans
xLetter
	"Form a word or keyword."

	| type |
	buffer reset.
	[(type := self typeTableAt: hereChar) == #xLetter or: [type == #xDigit]]
		whileTrue:
			["open code step for speed"
			buffer nextPut: hereChar.
			hereChar := aheadChar.
			aheadChar := source atEnd
							ifTrue: [DoItCharacter]
							ifFalse: [source next]].
	tokenType := (type == #colon and: [aheadChar ~~ $=])
					ifTrue: 
						[buffer nextPut: self step.
						"Allow any number of embedded colons in literal symbols"
						[(self typeTableAt: hereChar) == #colon] whileTrue:
							[buffer nextPut: self step].
						#keyword]
					ifFalse: [#word].
	token := buffer contents