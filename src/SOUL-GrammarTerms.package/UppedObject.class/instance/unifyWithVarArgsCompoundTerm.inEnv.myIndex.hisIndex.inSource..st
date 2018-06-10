unification
unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	| list |
	^((smalltalkValue isKindOf: SequenceableCollection)
		and: [(smalltalkValue isKindOf: String) not])
		ifTrue:
			[list := ListTerm newFromCollection: smalltalkValue.
			list unifyWithVarArgsCompoundTerm: aCompound inEnv: anEnv myIndex:
					sourceIndex hisIndex: targetIndex inSource: inSource]
		ifFalse: [false]