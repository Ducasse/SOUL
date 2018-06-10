accessing
methodClassTerm
	
	^methodClassTerm isNil
		ifTrue: [self defaultMethodClassTerm]
		ifFalse: [methodClassTerm]