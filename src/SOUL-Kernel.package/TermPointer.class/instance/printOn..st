printing
printOn: aStream
	
	(term species == Environment
		or:
			[(term isKindOf: UppedObject)
				and: [term smalltalkValue species == Environment]])
		ifTrue: [aStream write: '**env**']
		ifFalse: [term printOn: aStream].
	aStream write: ' @ '.
	envIndex printOn: aStream.
	aStream write: ':'.
	nextTerm printOn: aStream