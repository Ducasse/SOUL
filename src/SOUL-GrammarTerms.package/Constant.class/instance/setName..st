initialize
setName: aSymbol
	"initialize a constant. aSymbol can also contain an integer, in that case we must make it an integer"

	
	aSymbol isAllDigits
		ifTrue: [self setSmalltalkValue: aSymbol asNumber asInteger]
		ifFalse: [self setSmalltalkValue: aSymbol]