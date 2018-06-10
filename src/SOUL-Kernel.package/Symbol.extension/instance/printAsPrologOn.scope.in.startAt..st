*SOUL-Kernel
printAsPrologOn: aStream scope: id in: env startAt: idx
	
	| fixedCopy |
	(self contains: [:c | c isLetter not]) | self first isUppercase
		ifTrue:
			[fixedCopy := (self copyReplaceAll: '\' with: '\\') copyReplaceAll: '"'
				with: '\"'.
			aStream nextPut: $'.
			aStream nextPutAll: fixedCopy.
			aStream nextPut: $']
		ifFalse: [aStream nextPutAll: self]