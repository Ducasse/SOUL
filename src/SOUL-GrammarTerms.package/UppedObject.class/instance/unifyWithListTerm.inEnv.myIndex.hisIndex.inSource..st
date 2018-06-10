unification
unifyWithListTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	| list |
	^((smalltalkValue isKindOf: SequenceableCollection)
		and: [(smalltalkValue isKindOf: CharacterArray) not])
		ifTrue:
			[list := ListTerm newFromCollection: smalltalkValue.
			list unifyWithListTerm: aTerm inEnv: anEnv myIndex: myIndex hisIndex:
					hisIndex inSource: inSource]
		ifFalse: [false]