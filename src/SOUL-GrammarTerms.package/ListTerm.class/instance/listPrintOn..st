printing
listPrintOn: aStream
	"this method is called when we are printed inside another list"

	
	aStream write: ','.
	termsequence terms first printOn: aStream.
	(termsequence terms last isKindOf: ListTerm)
		| (termsequence terms last isKindOf: EmptyListConstant)
		ifTrue: [termsequence terms last listPrintOn: aStream]
		ifFalse:
			[aStream write: '|'.
			termsequence terms last printOn: aStream]