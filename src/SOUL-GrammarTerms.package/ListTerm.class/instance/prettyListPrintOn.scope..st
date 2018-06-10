printing
prettyListPrintOn: aStream scope: id
	"this method is called when we are printed inside another list"

	
	aStream write: ','.
	termsequence terms first prettyPrintOn: aStream scope: id.
	(termsequence terms last isKindOf: ListTerm)
		| (termsequence terms last isKindOf: EmptyListConstant)
		ifTrue: [termsequence terms last prettyListPrintOn: aStream scope: id]
		ifFalse:
			[aStream write: '|'.
			termsequence terms last prettyPrintOn: aStream scope: id]