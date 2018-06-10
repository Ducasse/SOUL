*SOUL-Kernel
printAsPrologOn: aStream scope: id in: env startAt: idx
	
	| fixedCopy |
	fixedCopy := (self copyReplaceAll: '\' with: '\\') copyReplaceAll: '"'
		with: '\"'.
	aStream nextPut: $".
	aStream nextPutAll: fixedCopy.
	aStream nextPut: $"