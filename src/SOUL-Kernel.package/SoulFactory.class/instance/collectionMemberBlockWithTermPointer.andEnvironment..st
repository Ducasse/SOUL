symbiotic clause support
collectionMemberBlockWithTermPointer: aTermPointer andEnvironment: anEnvironment
	"Returns block to be used in symbiotic implementation of collectionMember/2 clause. Called at run-time. Specialized for fuzzy logic. "

	
	^self subclassResponsibility