printing
printAsPrologListOn: aStream scope: id in: env startAt: idx
	"this method is called when we are printed inside another list"

	
	aStream write: ','.
	termsequence terms first printAsPrologOn: aStream scope: id in: env
		startAt: idx.
	termsequence terms last species == SoulFactory current makeVariable
		ifTrue:
			[aStream write: '|'.
			termsequence terms last printAsPrologOn: aStream scope: id in: env
				startAt: idx]
		ifFalse:
			[termsequence terms last printAsPrologListOn: aStream scope: id in: env
				startAt: idx]