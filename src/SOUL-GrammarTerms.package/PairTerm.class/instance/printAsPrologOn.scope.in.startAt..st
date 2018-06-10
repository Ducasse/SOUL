printing
printAsPrologOn: aStream scope: id in: env startAt: idx
	"see comment in AbstractTerm"

	
	aStream write: '['.
	termsequence terms first printAsPrologOn: aStream scope: id in: env
		startAt: idx.
	termsequence terms last isVariable
		ifTrue:
			[aStream write: '|'.
			termsequence terms last printAsPrologOn: aStream scope: id in: nil
				startAt: nil]
		ifFalse:
			[termsequence terms last printAsPrologListOn: aStream scope: id in: nil
				startAt: nil].
	aStream write: ']'