printing
printOn: aStream
	"see comment in AbstractTerm"

	
	aStream write: '<'.
	termsequence terms first printOn: aStream.
	(termsequence terms last isKindOf: ListTerm)
		| (termsequence terms last isKindOf: EmptyListConstant)
		ifTrue: [termsequence terms last listPrintOn: aStream]
		ifFalse:
			[aStream write: '|'.
			termsequence terms last printOn: aStream].
	aStream write: '>'