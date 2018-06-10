private
compactedContent
	
	| newContent previous string |
	newContent := OrderedCollection new.
	previous := WriteStream on: String new.
	content
		do:
			[:el | 
			string := el smalltalkBlockString.
			string size = 3
				ifTrue: [previous nextPut: (string at: 2)]
				ifFalse:
					[newContent add: (QuotedCodeConstant name: previous contents).
					previous := WriteStream on: String new.
					newContent add: el]].
	previous contents size > 0
		ifTrue: [newContent add: (QuotedCodeConstant name: previous contents)].
	^newContent