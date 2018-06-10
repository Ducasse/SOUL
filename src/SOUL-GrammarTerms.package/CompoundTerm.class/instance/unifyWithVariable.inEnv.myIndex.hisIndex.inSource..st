unification
unifyWithVariable: aVariable inEnv: anEnv myIndex: myIndex hisIndex: hisIndex inSource: inSource
	"we group all unfication with variables in the Variable class"

	
	| myAst |
	^(myAst := astlink soulDownIn: anEnv startAt: myIndex) class ==
			UppedASTObject
		ifTrue:
			[self halt.
			aVariable
				unifyWithUppedASTObject: myAst
				inEnv: anEnv
				myIndex: hisIndex
				hisIndex: myIndex
				inSource: inSource not]
		ifFalse:
			[aVariable
				unifyWithCompoundTerm: self
				inEnv: anEnv
				myIndex: hisIndex
				hisIndex: myIndex
				inSource: inSource not]