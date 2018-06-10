printing
prettyPrintOn: aStream scope: id
	"see comment in AbstractTerm"

	
	aStream write: '<'.
	termsequence terms first prettyPrintOn: aStream scope: id.
	(termsequence terms last isKindOf: ListTerm)
		| (termsequence terms last isKindOf: EmptyListConstant)
		ifTrue: [termsequence terms last prettyListPrintOn: aStream scope: id]
		ifFalse:
			[aStream write: '|'.
			termsequence terms last prettyPrintOn: aStream scope: id].
	aStream write: '>'