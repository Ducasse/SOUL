private
compilerForSmalltalkTermBlocks
	"TODO: Find a cleaner way to do make this Squeak compatible. Pass by the MLI which already has VW and Squeak-specific specializations?"

	
	^ClosureCompiler
		ifNil: [self class compilerClass]
		ifNotNil: [ClosureCompiler]