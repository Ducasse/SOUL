unification
unifyWithUppedObject: anObject inEnv: anEnv myIndex: sourceIndex hisIndex: targetIndex inSource: inSource
	
	| value |
	value := anObject smalltalkValue.
	value ifNil: [^false].
	^(self asSourceStringIn: anEnv startAt: sourceIndex) match: value