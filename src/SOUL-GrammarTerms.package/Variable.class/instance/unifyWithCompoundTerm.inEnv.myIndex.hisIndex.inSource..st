unification
unifyWithCompoundTerm: aCompound inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"I unify with a compound by binding to it or unifying my value with it"

	
	| val hisAst |
	(hisAst := aCompound astLink soulDownIn: anEnv startAt: hisIndex) class ==
			UppedASTObject
		ifTrue:
			[^self unifyWithUppedObject: hisAst inEnv: anEnv myIndex: myIndex hisIndex:
					hisIndex inSource: inSource]
		ifFalse:
			[val := anEnv lookup: self startAt: myIndex.
			val isNil
				ifTrue:
					[anEnv bind: self to: aCompound startAt: myIndex valueStartAt: hisIndex.
					^true]
				ifFalse:
					[^val term
						unifyWithCompoundTerm: aCompound
						inEnv: anEnv
						myIndex: val envIndex
						hisIndex: hisIndex
						inSource: inSource]]