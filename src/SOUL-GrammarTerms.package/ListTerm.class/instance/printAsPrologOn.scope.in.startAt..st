printing
printAsPrologOn: aStream scope: scope in: env startAt: idx
	"see comment in AbstractTerm"

	
	aStream write: '['.
	termsequence terms first printAsPrologOn: aStream scope: #clause in: env
		startAt: idx.
	termsequence terms last printAsPrologListOn: aStream scope: #clause in:
			nil startAt: nil.
	aStream write: ']'