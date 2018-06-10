unification
unifyWithUppedObject: anObject inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	
	| val |
	val := anObject soulDownIn: anEnv startAt: hisIndex.
	^((val isKindOf: SequenceableCollection)
		and: [(val isKindOf: CharacterArray) not])
		ifTrue: [^val isEmpty]
		ifFalse:
			[^super unifyWithUppedObject: anObject inEnv: anEnv myIndex: myIndex
				hisIndex: hisIndex inSource: inSource]