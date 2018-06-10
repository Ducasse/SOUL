*SOUL-Kernel
printAsPrologOn: aStream scope: id in: env startAt: idx
	"Most object cannot be translated to Prolog. Rather than outputting an error though, we output a stub."

	
	aStream nextPutAll: 'object'