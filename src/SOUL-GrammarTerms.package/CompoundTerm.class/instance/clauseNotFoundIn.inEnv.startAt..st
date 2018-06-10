resolving
clauseNotFoundIn: repository inEnv: env startAt: anIndex
	
	| val |
	((self functor isKindOf: Variable)
		and:
			[(val := self functor soulDownIn: env startAt: anIndex) class ==
					BlockClosure])
		ifTrue: [^self resolveAsApplication: val inEnv: env startAt: anIndex].
	^super clauseNotFoundIn: repository inEnv: env startAt: anIndex