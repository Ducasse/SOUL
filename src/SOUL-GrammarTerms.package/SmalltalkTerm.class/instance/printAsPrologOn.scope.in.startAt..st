printing
printAsPrologOn: aStream scope: id in: env startAt: idx
	
	self isLiteral
		ifTrue:
			[self literalValue printAsPrologOn: aStream scope: id in: env startAt: idx]
		ifFalse:
			["Rather than spitting out an error, this code will simply output the source of the Smalltalk term as a string in a compound term for later manual translation."

			aStream write: 'smalltalkterm /*' , source , '*/']